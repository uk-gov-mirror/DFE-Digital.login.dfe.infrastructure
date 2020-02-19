import config from "./config";
import { request } from "https";

const jwtStrategy = require("login.dfe.jwt-strategies");

// generate token
async function getToken(): Promise<string> {
  return await jwtStrategy(config.token).getBearerToken();
}

function makeRequest(token: string, body: string): Promise<any> {
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
        resolve(res);
      } else {
        reject(res);
      }
    });

    req.on("error", error => {
      reject(error);
    });

    req.write(DATA);
    req.end();
  });
}

function sleep(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms));
}

(async function run(): Promise<void> {
  let errorCode;
  try {
    let token = await getToken();
    await makeRequest(token, "stopped");
    await sleep(config.wait);
    await makeRequest(token, "started");
  } catch (e) {
    console.error(e);
    errorCode = 1;
  } finally {
    process.exit(errorCode);
  }
})();
