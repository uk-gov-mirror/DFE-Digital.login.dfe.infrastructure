import config from "./config";

import { request } from "https";
import { IncomingWebhook } from "@slack/webhook";
import Redis from 'ioredis';

const jwtStrategy = require("login.dfe.jwt-strategies");
const redis = new Redis(process.env.REDIS_STRING);

// generate token
async function getToken(): Promise<string> {
  return await jwtStrategy(config.token).getBearerToken();
}

function makeRequest(token: string, body: string): Promise<void> {
  const DATA = JSON.stringify({
    state: body
  });

  return new Promise((resolve, reject) => {
    const options = {
      hostname: config.endpoint,
      port: 443,
      path: "/monitor",
      method: "PATCH",
      headers: {
        "Content-Type": "application/json",
        "Content-Length": DATA.length,
        Authorization: `Bearer ${token}`
      }
    };

    const req = request(options, res => {
      if (res.statusCode === 200 || res.statusCode === 304) {
        resolve();
      } else {
        reject();
      }
    });

    req.on("error", error => {
      reject(error);
    });

    req.write(DATA);
    req.end();
  });
}

function sleep(ms: number = 1000): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms));
}

async function notify(title: string, msg: string): Promise<void> {
  return new Promise(async (resolve, reject) => {
    try {
      const webhook = new IncomingWebhook(process.env.SLACK_AUTOJOB_WEBOOK);

      await webhook.send({
        attachments: [
          {
            fallback: "Clear jobs ran",
            color: "#36a64f",
            author_name: "dfe.login.infrastructure",
            title: title,
            text: msg,
            footer: "Archronos",
            footer_icon:
              "http://archronos.com/wp-content/uploads/2019/02/square-1.png",
            ts: `${Date.now()}`
          }
        ]
      });

      resolve();
    } catch (e) {
      reject();
    }
  });
}

(async function run(): Promise<void> {




  let errorCode;
  try {
    let token = await getToken();
    await makeRequest(token, "stopped");
    // await notify("Jobs stopped", "KueJS jobs stopped");
    await sleep();
    await makeRequest(token, "started");
    // await notify("Jobs started", "KueJS jobs started");
  } catch (e) {
    console.error(e);
    errorCode = 1;
  } finally {
    console.log(`completed at ${new Date()}`)
    process.exit(errorCode);
  }
})();
