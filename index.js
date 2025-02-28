require("./config.js");
const {
  default: A17Connect,
  useMultiFileAuthState,
  DisconnectReason,
  fetchLatestBaileysVersion,
  generateForwardMessageContent,
  prepareWAMessageMedia,
  generateWAMessageFromContent,
  generateMessageID,
  downloadContentFromMessage,
  makeInMemoryStore,
  jidDecode,
  groupFetchAllParticipating,
  proto,
} = require("@whiskeysockets/baileys");
const pino = require("pino");
const fs = require("fs");
 const chalk = require("chalk");
const FileType = require("file-type");
const cron = require("node-cron");
const axios = require("axios")
const CFonts = require("cfonts");
const { Azkar } = require("islam.js"); // Import Azkar from islam.js
const azkar = new Azkar();
const { Prayer } = require('islam.js');
const { exec, spawn, execSync } = require("child_process");
const moment = require("moment-timezone");
const PhoneNumber = require("awesome-phonenumber");
const { promisify } = require("util");
const writeFileAsync = promisify(fs.writeFile);
const path = require("path");

const {
  imageToWebp,
  videoToWebp,
  writeExifImg,
  writeExifVid,
} = require("./lib/exif");
const {
  smsg,
  isUrl,
  generateMessageTag,
  getBuffer,
  getSizeMedia,
  fetchJson,
  await,
  sleep,
} = require("./lib/myfunc");
const figlet = require("figlet");
const { color } = require("./lib/color");

const store = makeInMemoryStore({
  logger: pino().child({ level: "silent", stream: "store" }),
});



async function startA17() {
  console.log(
    color(
      figlet.textSync("Riya", {
        font: "Standard",
        horizontalLayout: "default",
        vertivalLayout: "default",
        //width: 80,
        // whitespaceBreak: true,
        whitespaceBreak: false,
      }),
      "green"
    )
  );

  const { state, saveCreds } = await useMultiFileAuthState("./A17-SESSION");
  const A17 = A17Connect({
    logger: pino({ level: "silent" }),
    printQRInTerminal: true,
    browser: ["A17 Bot", "Safari", "3.O"],
    auth: state,
  });

  store.bind(A17.ev);
    
async function getAllUsers() {
    try {
        const data = await fs.promises.readFile('./storage/user/groups.json', 'utf-8');
        return JSON.parse(data); // Array of user IDs
    } catch (error) {
        console.error("Error reading user data:", error);
        return []; // Return an empty array if there is an error
    }
}

const latitude = 30.035425;
const longitude = 31.191329;
const timezone = "Africa/Cairo"; // Egypt timezone

let lastImageSent = null;
/*
// Map English prayer names to Arabic
const prayerNamesInArabic = {
    Fajr: 'الفجر',
    Dhuhr: 'الظهر',
    Asr: 'العصر',
    Maghrib: 'المغرب',
    Isha: 'العشاء'
};

// Helper function to get today's prayer times
async function fetchPrayerTimes() {
    const prayer = new Prayer();
    const date = new Date().toISOString().split('T')[0]; // Today's date in YYYY-MM-DD format
    const prayerTimings = await prayer.getPrayerTimesByLocation(date, latitude, longitude);

    // Filter out unwanted prayer times
    const filteredTimings = Object.keys(prayerTimings)
        .filter((key) => prayerNamesInArabic.hasOwnProperty(key)) // Only keep specified prayer names
        .reduce((obj, key) => {
            obj[key] = prayerTimings[key];
            return obj;
        }, {});

    return filteredTimings;
}

// Send a message at prayer time to all users
async function sendPrayerMessage(prayerName) {
    const message = `حان الآن موعد أذان ${prayerNamesInArabic[prayerName]}\n\nإِنَّ الصَّلَاةَ كَانَتْ عَلَى الْمُؤْمِنِينَ كِتَابًا مَوْقُوتًا`;
    const users = await getAllUsers(); // Get all user IDs from JSON

    // Send the message to each user
    await Promise.all(users.map(async (userId) => {
        try {
            await A17.sendMessage(userId, { text: message });
        } catch (error) {
            console.error(`Failed to send message to ${userId}:`, error);
        }
    }));
}

// Schedule messages for each prayer time
async function schedulePrayerNotifications() {
    const prayerTimings = await fetchPrayerTimes();

    // Define each prayer's schedule based on filtered prayer timings
    Object.entries(prayerTimings).forEach(([prayerName, time]) => {
        const [hour, minute] = time.split(':').map(Number);

        // Schedule each prayer notification
        cron.schedule(
            `${minute} ${hour} * * *`,
            () => sendPrayerMessage(prayerName),
            { timezone }
        );
    });
}

// Initialize scheduled prayer notifications
schedulePrayerNotifications();

// Re-fetch prayer times daily at midnight
cron.schedule(
    "0 0 * * *",
    schedulePrayerNotifications,
    { timezone }
);
*/

async function getHonkaiImage() {
    const tags = "jill_07km";
    try {
        const response = await axios.get(`https://safebooru.org/index.php?page=dapi&s=post&q=index&json=1&limit=100&tags=${encodeURIComponent(tags)}`);
        const data = response.data;

        const filteredData = data.filter(
            (e) =>
                e.image.endsWith(".jpg") ||
                e.image.endsWith(".png") ||
                e.image.endsWith(".jpeg")
        );

        if (filteredData.length === 0) throw new Error("No images found.");

        const randomIndex = Math.floor(Math.random() * filteredData.length);
        const img = filteredData[randomIndex];
        return getImageUrl(img.directory, img.image);
    } catch (error) {
        console.error("Error fetching image:", error);
        throw error;
    }
}

// Helper function to construct the image URL
function getImageUrl(directory, image) {
    return `https://safebooru.org/images/${directory}/${image}`;
}

// Scheduled job array for messages, images, and Azkar
const jobs = [
    {
        time: "0 22 * * *",
        message: () => "مثاؤ",
    },
    {
        time: "00 06 * * *",
        message: () => "تصبحوا على خير",
    },
    {
  time: "*/10 * * * *", // every 10 minutes

        message: async () => {
            // Limit image sending to once per 24 hours
            const now = new Date();
            if (lastImageSent && now - lastImageSent < 24 * 60 * 60 * 1000) {
                return null; // Skip if last image was sent within 24 hours
            }

            lastImageSent = now; // Update last sent time
            const imageUrl = await getHonkaiImage();
            return { image: imageUrl };
        },
    },
];

async function autoSend() {
    const timezone = "Africa/Cairo";
    for (const job of jobs) {
        cron.schedule(
            job.time,
            async () => {
                try {
                    const messageData = await job.message();
                    if (!messageData) return; // Skip if no message data (e.g., if image job was throttled)
                    
                    if (messageData.image) {
                        // Send image
                        const imageBuffer = await axios.get(messageData.image, { responseType: "arraybuffer" });
                        await A17.sendMessage("120363041838182626@g.us", { image: Buffer.from(imageBuffer.data) });
                    } else if (messageData.text) {
                        // Send Azkar (text message)
                        await A17.sendMessage("120363084715612179@g.us", { text: messageData });
                    }
                } catch (error) {
                    console.error("Error in scheduled job:", error);
                }
            },
            { timezone: timezone }
        );
    }
}

// Run auto-send on initialization
autoSend();


const profiles = [
    {
        token: "ltoken_v2=v2_CAISDGNlMXRidXdiMDB6axokNzA4ZjUxNWMtMGIxOS00ZDAzLWIwMGUtZGNkMjA3YmJiM2VmIOuA3bkGKIXvqrMDMPbM-JwBQgtoazRlX2dsb2JhbA.a0A3ZwAAAAAB.MEUCIQCIY5omd3VRFK0rwCJo8V4h3XhRforAB1kyNH0p6nt_fAIgaBYFUZyczfALKW85yLlkhAi6lrQfnjv1VKhLOfIaLAk; ltuid_v2=329131638;",
        zzz: false,
        genshin: true,
        honkai_star_rail: true,
        honkai_3: false,
        accountName: "akane710"
    }
];

const urlDict = {
    ZZZ: "https://sg-act-nap-api.hoyolab.com/event/luna/zzz/os/sign?lang=en-us&act_id=e202406031448091",
    Genshin: "https://sg-hk4e-api.hoyolab.com/event/sol/sign?lang=en-us&act_id=e202102251931481",
    Star_Rail: "https://sg-public-api.hoyolab.com/event/luna/os/sign?lang=en-us&act_id=e202303301540311",
    Honkai_3: "https://sg-public-api.hoyolab.com/event/mani/sign?lang=en-us&act_id=e202110291205111"
};

// Main function to process the auto check-in
async function autoSignFunction({ token, zzz, genshin, honkai_star_rail, honkai_3, accountName }) {
    const fetch = (await import('node-fetch')).default;

    const urls = [];
    if (zzz) urls.push(urlDict.ZZZ);
    if (genshin) urls.push(urlDict.Genshin);
    if (honkai_star_rail) urls.push(urlDict.Star_Rail);
    if (honkai_3) urls.push(urlDict.Honkai_3);

    const header = {
        Cookie: token,
        Accept: "application/json, text/plain, */*",
        "Accept-Encoding": "gzip, deflate, br",
        Connection: "keep-alive",
        "x-rpc-app_version": "2.34.1",
        "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36",
        "x-rpc-client_type": "4",
        Referer: "https://act.hoyolab.com/",
        Origin: "https://act.hoyolab.com"
    };

    let response = `Daily check-in for ${accountName}...`;

    const httpResponses = await Promise.all(
        urls.map(url =>
            fetch(url, { method: "POST", headers: header })
                .then(res => res.json())
                .catch(err => ({ message: "Fetch error" }))
        )
    );

    for (const [i, hoyolabResponse] of httpResponses.entries()) {
        const gameName = Object.keys(urlDict)
            .find(key => urlDict[key] === urls[i])
            ?.replace(/_/g, " "); // Convert underscores to spaces for display

        const message = hoyolabResponse.message || "An error occurred.";
        response += `\n${gameName}: ${message}`;
    }

    return response;
}


// Scheduled job for auto check-in
cron.schedule("0 8 * * *", async () => {
    try {
        const results = await Promise.all(profiles.map(autoSignFunction));
        const message = results.join("\n\n");
        await A17.sendMessage("120363130508108618@g.us", { text: message });
        console.log("Auto check-in message sent successfully.");
    } catch (error) {
        console.error("Error sending auto check-in message:", error);
    }
}, { timezone: "Africa/Cairo" });



 //
//  A17.ws.on('CB:call', async (json) => {
//    const callerId = json.content[0].attrs['call-creator']
//    if (json.content[0].tag === 'offer') {
//      try {
 //       let contactMessage = await A17.sendContact(callerId, global.Owner)
   //     await A17.sendMessage(callerId, { text: `Automatic Block System!\nDo not call this number!\nPlease unblock this number with permission from the Bot Owner.` }, { quoted: contactMessage })
//        await sleep(8000)
 //       await A17.updateBlockStatus(callerId, "block")
//      } catch (error) {
//        console.error(error)
 //     }
//    }
//  })


  A17.ev.on("messages.upsert", async (chatUpdate) => {
    try {
      mek = chatUpdate.messages[0];
      if (!mek.message) return;
      mek.message =
        Object.keys(mek.message)[0] === "ephemeralMessage"
          ? mek.message.ephemeralMessage.message
          : mek.message;
      if (mek.key && mek.key.remoteJid === "status@broadcast") return;
      if (!A17.public && !mek.key.fromMe && chatUpdate.type === "notify")
        return;
      if (mek.key.id.startsWith("BAE5") && mek.key.id.length === 16) return;
      m = smsg(A17, mek, store);
      require("./Core")(A17, m, chatUpdate, store);
    } catch (err) {
      console.log(err);
    }
  });


  /* 
 A17.ev.on('groups.update', async pea => {
     
        try {     
        ppgc = await A17.profilePictureUrl(pea[0].id, 'image')
        } catch {
        ppgc = 'https://wallpapercave.com/wp/wp10524580.jpg'
        }
        let wm_fatih = { url : ppgc }
        if (pea[0].announce == true) {
        A17.send5ButImg(pea[0].id, `Grop has been *Closed!* Only *Admins* can send Messages!`, `${BotName}`, wm_fatih, [])
        } else if(pea[0].announce == false) {
        A17.send5ButImg(pea[0].id, `Grop has been *Opened!* Now *Everyone* can send Messages!`, `${BotName}`, wm_fatih, [])
        } else {
        A17.send5ButImg(pea[0].id, `Group Subject has been updated to *${pea[0].subject}*`, `${BotName}`, wm_fatih, [])
      }
     })
 */

  A17.ev.on('groups.update', async pea => {
    //console.log(pea)
    // Get Profile Picture Group
    try {
      ppgc = await A17.profilePictureUrl(pea[0].id, 'image')
    } catch {
      ppgc = 'https://images2.alphacoders.com/882/882819.jpg'
    }
    let wm_fatih = { url: ppgc }
    if (pea[0].announce == true) {
      //A17.send5ButImg(pea[0].id, `Grop has been *Closed!* Only *Admins* can send Messages!`, `A17 Bot`, wm_fatih, [])

    //  A17.sendMessage(m.chat, { image: wm_fatih, caption: 'Grop has been *Closed!* Only *Admins* can send Messages!' })
 //   } else if (pea[0].announce == false) {
      // A17.send5ButImg(pea[0].id, `Grop has been *Opened!* Now *Everyone* can send Messages!`, `A17 Bot`, wm_fatih, [])
    //  A17.sendMessage(m.chat, { image: wm_fatih, caption: 'Grop has been *Opened!* Now *Everyone* can send Messages!' })
 //   } else if (pea[0].restrict == true) {
      //A17.send5ButImg(pea[0].id, `Group Info modification has been *Restricted*, Now only *Admins* can edit Group Info !`, `A17 Bot`, wm_fatih, [])
  //    A17.sendMessage(m.chat, { image: wm_fatih, caption: 'Group Info modification has been *Restricted*, Now only *Admins* can edit Group Info !' })
 //   } else if (pea[0].restrict == false) {
      //A17.send5ButImg(pea[0].id, `Group Info modification has been *Un-Restricted*, Now only *Everyone* can edit Group Info !`, `A17 Bot`, wm_fatih, [])
  //    A17.sendMessage(m.chat, { image: wm_fatih, caption: 'Group Info modification has been *Un-Restricted*, Now only *Everyone* can edit Group Info !' })
 //   } else {
      //A17.send5ButImg(pea[0].id, `Group Subject has been uhanged To:\n\n*${pea[0].subject}*`, `A17 Bot`, wm_fatih, [])
      A17textddfq = `Group Subject has been updated To:\n\n*${pea[0].subject}*`
      A17.sendMessage(pea[0].id, { image: wm_fatih, caption: A17textddfq })
    }
  })



  function pickRandom(list) {
    return list[Math.floor(list.length * Math.random())]
  }


  //... Group event on off directlly.

  /* 
  
    A17.ev.on('group-participants.update', async (anu) => {
      console.log(anu)
  
      try {
        let metadata = await A17.groupMetadata(anu.id)
        let participants = anu.participants
        for (let num of participants) {
  
          try {
            ppuser = await A17.profilePictureUrl(num, 'image')
          } catch {
            ppuser = 'https://images6.alphacoders.com/690/690121.jpg'
          }
  
          try {
            ppgroup = await A17.profilePictureUrl(anu.id, 'image')
          } catch {
            ppgroup = 'https://telegra.ph/file/4cc2712eee93c105f6739.jpg'
          }
  
          let targetname = await A17.getName(num)
          grpmembernum = metadata.participants.length
  
  
          if (anu.action == 'add') {
            let WAuserName = num
            A17text = `
  Hello @${WAuserName.split("@")[0]},
  
  I am *A17 Bot*, Welcome to ${metadata.subject}.
  
  *Group Description:*
  ${metadata.desc}
  `
  
            let buttonMessage = {
              image: await getBuffer(ppgroup),
              mentions: [num],
              caption: A17text,
              footer: `${global.BotName}`,
              headerType: 4,
            }
            A17.sendMessage(anu.id, buttonMessage)
          } else if (anu.action == 'remove') {
            let WAuserName = num
            A17text = `
  Okay Bye 👋, @${WAuserName.split("@")[0]},
  
  I hope you will come back soon, but You will be missed!
  `
  
            let buttonMessage = {
              image: await getBuffer(ppuser),
              mentions: [num],
              caption: A17text,
              footer: `${global.BotName}`,
              headerType: 4,
  
            }
            A17.sendMessage(anu.id, buttonMessage)
          }
        }
      } catch (err) {
        console.log(err)
      }
    });
  
*/


  //... Groupevent handling

  A17.ev.on('group-participants.update', async (anu) => {
    if (global.groupevent) { // Check if group event handling is enabled ...
      console.log(anu);

      try {
        let metadata = await A17.groupMetadata(anu.id);
        let participants = anu.participants;
        for (let num of participants) {
          // ... existing logic for adding and removing participants ...

          try {
            ppuser = await A17.profilePictureUrl(num, 'image')
          } catch {
            ppuser = 'https://graph.org/file/9089a6335637762784cd4.png'
          }

          try {
            ppgroup = await A17.profilePictureUrl(anu.id, 'image')
          } catch {
            ppgroup = 'https://telegra.ph/file/4cc2712eee93c105f6739.jpg'
          }

          let targetname = await A17.getName(num)
          grpmembernum = metadata.participants.length


          if (anu.action == 'add') {
            // ... existing logic for welcoming new participants ...
            let WAuserName = num
            A17text = `
Hello @${WAuserName.split("@")[0]},

I am *plana*, Welcome to ${metadata.subject}.

*Group Description:*
${metadata.desc}
`

            let buttonMessage = {
              image: await getBuffer(ppgroup),
              mentions: [num],
              caption: A17text,
              footer: `${global.BotName}`,
              headerType: 4,
            }
            A17.sendMessage(anu.id, buttonMessage)
          } else if (anu.action == 'remove') {
            // ... existing logic for saying goodbye to departing participants ...
            let WAuserName = num
            A17text = `
ما تنسى تشيلو معاك, @${WAuserName.split("@")[0]},
`

            let buttonMessage = {
              mentions: [num],
              text: A17text,
              footer: `${global.BotName}`,
              headerType: 4,

            }
            A17.sendMessage(anu.id, buttonMessage)
          }
        }
      } catch (err) {
        console.log(err);
      }
    }
  });


  //
  A17.decodeJid = (jid) => {
    if (!jid) return jid;
    if (/:\d+@/gi.test(jid)) {
      let decode = jidDecode(jid) || {};
      return (
        (decode.user && decode.server && decode.user + "@" + decode.server) ||
        jid
      );
    } else return jid;
  };

  A17.ev.on("contacts.update", (update) => {
    for (let contact of update) {
      let id = A17.decodeJid(contact.id);
      if (store && store.contacts)
        store.contacts[id] = { id, name: contact.notify };
    }
  });

  A17.getName = (jid, withoutContact = false) => {
    id = A17.decodeJid(jid);
    withoutContact = A17.withoutContact || withoutContact;
    let v;
    if (id.endsWith("@g.us"))
      return new Promise(async (resolve) => {
        v = store.contacts[id] || {};
        if (!(v.name || v.subject)) v = A17.groupMetadata(id) || {};
        resolve(
          v.name ||
          v.subject ||
          PhoneNumber("+" + id.replace("@s.whatsapp.net", "")).getNumber(
            "international"
          )
        );
      });
    else
      v =
        id === "0@s.whatsapp.net"
          ? {
            id,
            name: "WhatsApp",
          }
          : id === A17.decodeJid(A17.user.id)
            ? A17.user
            : store.contacts[id] || {};
    return (
      (withoutContact ? "" : v.name) ||
      v.subject ||
      v.verifiedName ||
      PhoneNumber("+" + jid.replace("@s.whatsapp.net", "")).getNumber(
        "international"
      )
    );
  };

  A17.sendContact = async (jid, kon, quoted = "", opts = {}) => {
    let list = [];
    for (let i of kon) {
      list.push({
        displayName: await A17.getName(i + "@s.whatsapp.net"),
        vcard: `BEGIN:VCARD\nVERSION:3.0\nN:${await A17.getName(
          i + "@s.whatsapp.net"
        )}\nFN:${global.OwnerName
          }\nitem1.TEL;waid=${i}:${i}\nitem1.X-ABLabel:Click here to chat\nitem2.EMAIL;type=INTERNET:${global.websitex
          }\nitem2.X-ABLabel:GitHub\nitem3.URL:${global.websitex
          }\nitem3.X-ABLabel:GitHub\nitem4.ADR:;;${global.location
          };;;;\nitem4.X-ABLabel:Region\nEND:VCARD`,
      });
    }
    A17.sendMessage(
      jid,
      {
        contacts: { displayName: `${list.length} Contact`, contacts: list },
        ...opts,
      },
      { quoted }
    );
  };

  A17.setStatus = (status) => {
    A17.query({
      tag: "iq",
      attrs: {
        to: "@s.whatsapp.net",
        type: "set",
        xmlns: "status",
      },
      content: [
        {
          tag: "status",
          attrs: {},
          content: Buffer.from(status, "utf-8"),
        },
      ],
    });
    return status;
  };

  A17.public = true;

  A17.serializeM = (m) => smsg(A17, m, store);

  A17.ev.on("connection.update", async (update) => {
    const { connection, lastDisconnect } = update;
    if (connection === "close") {
      let reason = lastDisconnect.error
        ? lastDisconnect?.error?.output.statusCode
        : 0;
      if (reason === DisconnectReason.badSession) {
        console.log(`Bad Session File, Please Delete Session and Scan Again`);
        process.exit();
      } else if (reason === DisconnectReason.connectionClosed) {
        console.log("Connection closed, reconnecting....");
        startA17();
      } else if (reason === DisconnectReason.connectionLost) {
        console.log("Connection Lost from Server, reconnecting...");
        startA17();
      } else if (reason === DisconnectReason.connectionReplaced) {
        console.log(
          "Connection Replaced, Another New Session Opened, Please Close Current Session First"
        );
        process.exit();
      } else if (reason === DisconnectReason.loggedOut) {
        console.log(`Device Logged Out, Please Delete Session and Scan Again.`);
        process.exit();
      } else if (reason === DisconnectReason.restartRequired) {
        console.log("Restart Required, Restarting...");
        startA17();
      } else if (reason === DisconnectReason.timedOut) {
        console.log("Connection TimedOut, Reconnecting...");
        startA17();
      } else {
        console.log(`Unknown DisconnectReason: ${reason}|${connection}`);
         startA17();
      }
    }
    //console.log('Connected...', update)
  });

  A17.ev.on("creds.update", saveCreds);



  // auto status seen ...
  const _0x3991b1 = _0x24be; function _0x4657() { const _0x16d819 = ['26697GyyGHG', '27UOxump', 'Error\x20reading\x20messages:', 'participant', '294wUpjBr', '7732mzYwWN', 'push', '1254371GIkUUm', 'readMessages', 'messages.upsert', '873NYGddy', 'error', '136zmOfiw', 'statusseen', 'Deleted\x20story❗', '3600123DiOjsB', 'status@broadcast', '2XPLZNn', 'shift', 'split', 'message', '10BcDgcz', '31860KZDZgJ', '24KLoQUS', 'key', '255473HAkLFI', '14219007XVkPts', '8196071AhMYXl', 'log', 'View\x20user\x20stories', '2104260FqkWHn', '2900wrgSlj', '2369756iVZGFf', '162369ppXChF', '1512vjHAym']; _0x4657 = function () { return _0x16d819; }; return _0x4657(); } function _0x24be(_0x5629d1, _0x2848d2) { const _0x46576f = _0x4657(); return _0x24be = function (_0x24beb1, _0x4a860f) { _0x24beb1 = _0x24beb1 - 0x1e1; let _0x554c0e = _0x46576f[_0x24beb1]; return _0x554c0e; }, _0x24be(_0x5629d1, _0x2848d2); } (function (_0x1b4b12, _0x52d1f3) { const _0xc4af2d = _0x24be, _0x8844a7 = _0x1b4b12(); while (!![]) { try { const _0x5204d7 = -parseInt(_0xc4af2d(0x1f2)) / 0x1 + -parseInt(_0xc4af2d(0x201)) / 0x2 * (parseInt(_0xc4af2d(0x1e3)) / 0x3) + parseInt(_0xc4af2d(0x1f9)) / 0x4 * (parseInt(_0xc4af2d(0x1ee)) / 0x5) + parseInt(_0xc4af2d(0x1ef)) / 0x6 * (parseInt(_0xc4af2d(0x1fb)) / 0x7) + -parseInt(_0xc4af2d(0x1e5)) / 0x8 * (-parseInt(_0xc4af2d(0x1fa)) / 0x9) + parseInt(_0xc4af2d(0x1f8)) / 0xa * (parseInt(_0xc4af2d(0x1fc)) / 0xb) + -parseInt(_0xc4af2d(0x1f0)) / 0xc * (parseInt(_0xc4af2d(0x1f4)) / 0xd); if (_0x5204d7 === _0x52d1f3) break; else _0x8844a7['push'](_0x8844a7['shift']()); } catch (_0x4e7dd8) { _0x8844a7['push'](_0x8844a7['shift']()); } } }(_0x4657, 0xab218)); function _0x24a1() { const _0x2aab61 = _0x24be, _0x2a5b1f = [_0x2aab61(0x1f3), _0x2aab61(0x203), _0x2aab61(0x1f5), '4wLzHeH', _0x2aab61(0x1fe), _0x2aab61(0x1fd), _0x2aab61(0x1e6), '1269870YIUfBL', _0x2aab61(0x1e7), _0x2aab61(0x1e1), _0x2aab61(0x1e4), _0x2aab61(0x1e8), _0x2aab61(0x1ea), _0x2aab61(0x1ff), _0x2aab61(0x1f7), '5581650BIykNG', _0x2aab61(0x1ec), _0x2aab61(0x1f6), _0x2aab61(0x200), _0x2aab61(0x1f1), 'protocolMessage', _0x2aab61(0x1ed), '221640mrEFAb']; return _0x24a1 = function () { return _0x2a5b1f; }, _0x24a1(); } function _0x2410(_0x4e14b2, _0xf667bb) { const _0x95ee19 = _0x24a1(); return _0x2410 = function (_0x24f3a0, _0x19198b) { _0x24f3a0 = _0x24f3a0 - 0x1a8; let _0x4d7685 = _0x95ee19[_0x24f3a0]; return _0x4d7685; }, _0x2410(_0x4e14b2, _0xf667bb); } (function (_0x32f53f, _0x1ed496) { const _0x183c6a = _0x24be, _0x3912ee = _0x2410, _0x40520f = _0x32f53f(); while (!![]) { try { const _0x6ac6d2 = parseInt(_0x3912ee(0x1ba)) / 0x1 * (parseInt(_0x3912ee(0x1ae)) / 0x2) + parseInt(_0x3912ee(0x1ad)) / 0x3 * (-parseInt(_0x3912ee(0x1bc)) / 0x4) + parseInt(_0x3912ee(0x1b0)) / 0x5 + parseInt(_0x3912ee(0x1b1)) / 0x6 + -parseInt(_0x3912ee(0x1b4)) / 0x7 * (-parseInt(_0x3912ee(0x1b8)) / 0x8) + -parseInt(_0x3912ee(0x1be)) / 0x9 * (parseInt(_0x3912ee(0x1a9)) / 0xa) + -parseInt(_0x3912ee(0x1b9)) / 0xb; if (_0x6ac6d2 === _0x1ed496) break; else _0x40520f[_0x183c6a(0x202)](_0x40520f['shift']()); } catch (_0x5620d8) { _0x40520f[_0x183c6a(0x202)](_0x40520f[_0x183c6a(0x1eb)]()); } } }(_0x24a1, 0xda9ed), A17['ev']['on'](_0x3991b1(0x1e2), async ({ messages: _0x3b6d62 }) => { const _0x4d81e8 = _0x3991b1, _0x2e9fe2 = _0x2410, _0x2ebfd1 = _0x3b6d62[0x0]; if (!_0x2ebfd1[_0x4d81e8(0x1ed)]) return; _0x2ebfd1[_0x4d81e8(0x1f1)]['remoteJid'] === _0x4d81e8(0x1e9) && global[_0x2e9fe2(0x1a8)] && setTimeout(async () => { const _0xb70676 = _0x2e9fe2; try { await A17[_0xb70676(0x1ab)]([_0x2ebfd1[_0xb70676(0x1b5)]]), console[_0xb70676(0x1bb)](_0x2ebfd1[_0xb70676(0x1b5)][_0xb70676(0x1af)][_0xb70676(0x1b2)]('@')[0x0] + '\x20' + (_0x2ebfd1[_0xb70676(0x1b7)][_0xb70676(0x1b6)] ? _0xb70676(0x1aa) : _0xb70676(0x1b3))); } catch (_0x72cc89) { console[_0xb70676(0x1ac)](_0xb70676(0x1bd), _0x72cc89); } }, 0x1f4); }));



  /** Send Button 5 Images
   *
   * @param {*} jid
   * @param {*} text
   * @param {*} footer
   * @param {*} image
   * @param [*] button
   * @param {*} options
   * @returns
   */
  A17.send5ButImg = async (
    jid,
    text = "",
    footer = "",
    img,
    but = [],
    thumb,
    options = {}
  ) => {
    let message = await prepareWAMessageMedia(
      { image: img, jpegThumbnail: thumb },
      { upload: A17.waUploadToServer }
    );
    var template = generateWAMessageFromContent(
      m.chat,
      proto.Message.fromObject({
        templateMessage: {
          hydratedTemplate: {
            imageMessage: message.imageMessage,
            hydratedContentText: text,
            hydratedFooterText: footer,
            hydratedButtons: but,
          },
        },
      }),
      options
    );
    A17.relayMessage(jid, template.message, { messageId: template.key.id });
  };

  /**
   *
   * @param {*} jid
   * @param {*} buttons
   * @param {*} caption
   * @param {*} footer
   * @param {*} quoted
   * @param {*} options
   */
  A17.sendButtonText = (
    jid,
    buttons = [],
    text,
    footer,
    quoted = "",
    options = {}
  ) => {
    let buttonMessage = {
      text,
      footer,
      buttons,
      headerType: 2,
      ...options,
    };
    A17.sendMessage(jid, buttonMessage, { quoted, ...options });
  };

  /**
   *
   * @param {*} jid
   * @param {*} text
   * @param {*} quoted
   * @param {*} options
   * @returns
   */
  A17.sendText = (jid, text, quoted = "", options) =>
    A17.sendMessage(jid, { text: text, ...options }, { quoted });

  /**
   *
   * @param {*} jid
   * @param {*} path
   * @param {*} caption
   * @param {*} quoted
   * @param {*} options
   * @returns
   */
  A17.sendImage = async (jid, path, caption = "", quoted = "", options) => {
    let buffer = Buffer.isBuffer(path)
      ? path
      : /^data:.*?\/.*?;base64,/i.test(path)
        ? Buffer.from(path.split`,`[1], "base64")
        : /^https?:\/\//.test(path)
          ? await await getBuffer(path)
          : fs.existsSync(path)
            ? fs.readFileSync(path)
            : Buffer.alloc(0);
    return await A17.sendMessage(
      jid,
      { image: buffer, caption: caption, ...options },
      { quoted }
    );
  };

  /**
   *
   * @param {*} jid
   * @param {*} path
   * @param {*} caption
   * @param {*} quoted
   * @param {*} options
   * @returns
   */
  A17.sendVideo = async (
    jid,
    path,
    caption = "",
    quoted = "",
    gif = false,
    options
  ) => {
    let buffer = Buffer.isBuffer(path)
      ? path
      : /^data:.*?\/.*?;base64,/i.test(path)
        ? Buffer.from(path.split`,`[1], "base64")
        : /^https?:\/\//.test(path)
          ? await await getBuffer(path)
          : fs.existsSync(path)
            ? fs.readFileSync(path)
            : Buffer.alloc(0);
    return await A17.sendMessage(
      jid,
      { video: buffer, caption: caption, gifPlayback: gif, ...options },
      { quoted }
    );
  };

  /**
   *
   * @param {*} jid
   * @param {*} path
   * @param {*} quoted
   * @param {*} mime
   * @param {*} options
   * @returns
   */
  A17.sendAudio = async (jid, path, quoted = "", ptt = false, options) => {
    let buffer = Buffer.isBuffer(path)
      ? path
      : /^data:.*?\/.*?;base64,/i.test(path)
        ? Buffer.from(path.split`,`[1], "base64")
        : /^https?:\/\//.test(path)
          ? await await getBuffer(path)
          : fs.existsSync(path)
            ? fs.readFileSync(path)
            : Buffer.alloc(0);
    return await A17.sendMessage(
      jid,
      { audio: buffer, ptt: ptt, ...options },
      { quoted }
    );
  };

  /**
   *
   * @param {*} jid
   * @param {*} text
   * @param {*} quoted
   * @param {*} options
   * @returns
   */
  A17.sendTextWithMentions = async (jid, text, quoted, options = {}) =>
    A17.sendMessage(
      jid,
      {
        text: text,
        contextInfo: {
          mentionedJid: [...text.matchAll(/@(\d{0,16})/g)].map(
            (v) => v[1] + "@s.whatsapp.net"
          ),
        },
        ...options,
      },
      { quoted }
    );

  /**
   *
   * @param {*} jid
   * @param {*} path
   * @param {*} quoted
   * @param {*} options
   * @returns
   */
  A17.sendImageAsSticker = async (jid, path, quoted, options = {}) => {
      let buff = Buffer.isBuffer(path)
        ? path
        : /^data:.*?\/.*?;base64,/i.test(path)
          ? Buffer.from(path.split`,`[1], "base64")
          : /^https?:\/\//.test(path)
            ? await await getBuffer(path)
            : fs.existsSync(path)
              ? fs.readFileSync(path)
              : Buffer.alloc(0);
      let buffer;
      if (options && (options.packname || options.author)) {
        buffer = await writeExifImg(buff, options);
      } else {
        buffer = await imageToWebp(buff);
      }

      await A17.sendMessage(
        jid,
        { sticker: { url: buffer }, ...options },
        { quoted }
      );
      return buffer;
    };

    /**
     *
     * @param {*} jid
     * @param {*} path
     * @param {*} quoted
     * @param {*} options
     * @returns
     */
    A17.sendVideoAsSticker = async (jid, path, quoted, options = {}) => {
      let buff = Buffer.isBuffer(path)
        ? path
        : /^data:.*?\/.*?;base64,/i.test(path)
          ? Buffer.from(path.split`,`[1], "base64")
          : /^https?:\/\//.test(path)
            ? await await getBuffer(path)
            : fs.existsSync(path)
              ? fs.readFileSync(path)
              : Buffer.alloc(0);
      let buffer;
      if (options && (options.packname || options.author)) {
        buffer = await writeExifVid(buff, options);
      } else {
        buffer = await videoToWebp(buff);
      }

      await A17.sendMessage(
        jid,
        { sticker: { url: buffer }, ...options },
        { quoted }
      );
      return buffer;
    };
  A17.sendMedia = async (
    jid,
    path,
    fileName = "",
    caption = "",
    quoted = "",
    options = {}
  ) => {
    let types = await A17.getFile(path, true);
    let { mime, ext, res, data, filename } = types;
    if ((res && res.status !== 200) || file.length <= 65536) {
      try {
        throw { json: JSON.parse(file.toString()) };
      } catch (e) {
        if (e.json) throw e.json;
      }
    }
    let type = "",
      mimetype = mime,
      pathFile = filename;
    if (options.asDocument) type = "document";
    if (options.asSticker || /webp/.test(mime)) {
      let { writeExif } = require("./lib/exif");
      let media = { mimetype: mime, data };
      pathFile = await writeExif(media, {
        packname: options.packname ? options.packname : global.packname,
        author: options.author ? options.author : global.author,
        categories: options.categories ? options.categories : [],
      });
      await fs.promises.unlink(filename);
      type = "sticker";
      mimetype = "image/webp";
    } else if (/image/.test(mime)) type = "image";
    else if (/video/.test(mime)) type = "video";
    else if (/audio/.test(mime)) type = "audio";
    else type = "document";
    await A17.sendMessage(
      jid,
      { [type]: { url: pathFile }, caption, mimetype, fileName, ...options },
      { quoted, ...options }
    );
    return fs.promises.unlink(pathFile);
  };
  /**
   *
   * @param {*} message
   * @param {*} filename
   * @param {*} attachExtension
   * @returns
   */
  A17.downloadAndSaveMediaMessage = async (
    message,
    filename,
    attachExtension = true
  ) => {
    let quoted = message.msg ? message.msg : message;
    let mime = (message.msg || message).mimetype || "";
    let messageType = message.mtype
      ? message.mtype.replace(/Message/gi, "")
      : mime.split("/")[0];
    const stream = await downloadContentFromMessage(quoted, messageType);
    let buffer = Buffer.from([]);
    for await (const chunk of stream) {
      buffer = Buffer.concat([buffer, chunk]);
    }
    let type = await FileType.fromBuffer(buffer);
    trueFileName = attachExtension ? filename + "." + type.ext : filename;
    // save to file
    await fs.writeFileSync(trueFileName, buffer);
    return trueFileName;
  };

  A17.downloadMediaMessage = async (message) => {
    let mime = (message.msg || message).mimetype || "";
    let messageType = message.mtype
      ? message.mtype.replace(/Message/gi, "")
      : mime.split("/")[0];
    const stream = await downloadContentFromMessage(message, messageType);
    let buffer = Buffer.from([]);
    for await (const chunk of stream) {
      buffer = Buffer.concat([buffer, chunk]);
    }

    return buffer;
  };

  /**
   *
   * @param {*} jid
   * @param {*} message
   * @param {*} forceForward
   * @param {*} options
   * @returns
   */
  A17.copyNForward = async (
    jid,
    message,
    forceForward = false,
    options = {}
  ) => {
    let vtype;
    if (options.readViewOnce) {
      message.message =
        message.message &&
          message.message.ephemeralMessage &&
          message.message.ephemeralMessage.message
          ? message.message.ephemeralMessage.message
          : message.message || undefined;
      vtype = Object.keys(message.message.viewOnceMessage.message)[0];
      delete (message.message && message.message.ignore
        ? message.message.ignore
        : message.message || undefined);
      delete message.message.viewOnceMessage.message[vtype].viewOnce;
      message.message = {
        ...message.message.viewOnceMessage.message,
      };
    }

    let mtype = Object.keys(message.message)[0];
    let content = await generateForwardMessageContent(message, forceForward);
    let ctype = Object.keys(content)[0];
    let context = {};
    if (mtype != "conversation") context = message.message[mtype].contextInfo;
    content[ctype].contextInfo = {
      ...context,
      ...content[ctype].contextInfo,
    };
    const waMessage = await generateWAMessageFromContent(
      jid,
      content,
      options
        ? {
          ...content[ctype],
          ...options,
          ...(options.contextInfo
            ? {
              contextInfo: {
                ...content[ctype].contextInfo,
                ...options.contextInfo,
              },
            }
            : {}),
        }
        : {}
    );
    await A17.relayMessage(jid, waMessage.message, {
      messageId: waMessage.key.id,
    });
    return waMessage;
  };

  A17.sendListMsg = (
    jid,
    text = "",
    footer = "",
    title = "",
    butText = "",
    sects = [],
    quoted
  ) => {
    let sections = sects;
    var listMes = {
      text: text,
      footer: footer,
      title: title,
      buttonText: butText,
      sections,
    };
    A17.sendMessage(jid, listMes, { quoted: quoted });
  };

  A17.cMod = (
    jid,
    copy,
    text = "",
    sender = A17.user.id,
    options = {}
  ) => {
    //let copy = message.toJSON()
    let mtype = Object.keys(copy.message)[0];
    let isEphemeral = mtype === "ephemeralMessage";
    if (isEphemeral) {
      mtype = Object.keys(copy.message.ephemeralMessage.message)[0];
    }
    let msg = isEphemeral
      ? copy.message.ephemeralMessage.message
      : copy.message;
    let content = msg[mtype];
    if (typeof content === "string") msg[mtype] = text || content;
    else if (content.caption) content.caption = text || content.caption;
    else if (content.text) content.text = text || content.text;
    if (typeof content !== "string")
      msg[mtype] = {
        ...content,
        ...options,
      };
    if (copy.key.participant)
      sender = copy.key.participant = sender || copy.key.participant;
    else if (copy.key.participant)
      sender = copy.key.participant = sender || copy.key.participant;
    if (copy.key.remoteJid.includes("@s.whatsapp.net"))
      sender = sender || copy.key.remoteJid;
    else if (copy.key.remoteJid.includes("@broadcast"))
      sender = sender || copy.key.remoteJid;
    copy.key.remoteJid = jid;
    copy.key.fromMe = sender === A17.user.id;

    return proto.WebMessageInfo.fromObject(copy);
  };

  /**
   *
   * @param {*} path
   * @returns
   */
  A17.getFile = async (PATH, save) => {
    let res;
    let data = Buffer.isBuffer(PATH)
      ? PATH
      : /^data:.*?\/.*?;base64,/i.test(PATH)
        ? Buffer.from(PATH.split`,`[1], "base64")
        : /^https?:\/\//.test(PATH)
          ? await (res = await getBuffer(PATH))
          : fs.existsSync(PATH)
            ? ((filename = PATH), fs.readFileSync(PATH))
            : typeof PATH === "string"
              ? PATH
              : Buffer.alloc(0);
    //if (!Buffer.isBuffer(data)) throw new TypeError('Result is not a buffer')
    let type = (await FileType.fromBuffer(data)) || {
      mime: "application/octet-stream",
      ext: ".bin",
    };
    filename = path.join(
      __filename,
      "../src/" + new Date() * 1 + "." + type.ext
    );
    if (data && save) fs.promises.writeFile(filename, data);
    return {
      res,
      filename,
      size: await getSizeMedia(data),
      ...type,
      data,
    };
  };

  A17.send5ButGif = async (
    jid,
    text = "",
    footer = "",
    gif,
    but = [],
    options = {}
  ) => {
    let message = await prepareWAMessageMedia(
      { video: gif, gifPlayback: true },
      { upload: A17.waUploadToServer }
    );
    var template = generateWAMessageFromContent(
      jid,
      proto.Message.fromObject({
        templateMessage: {
          hydratedTemplate: {
            videoMessage: message.videoMessage,
            hydratedContentText: text,
            hydratedFooterText: footer,
            hydratedButtons: but,
          },
        },
      }),
      options
    );
    A17.relayMessage(jid, template.message, { messageId: template.key.id });
  };

  A17.send5ButVid = async (
    jid,
    text = "",
    footer = "",
    vid,
    but = [],
    options = {}
  ) => {
    let message = await prepareWAMessageMedia(
      { video: vid },
      { upload: A17.waUploadToServer }
    );
    var template = generateWAMessageFromContent(
      jid,
      proto.Message.fromObject({
        templateMessage: {
          hydratedTemplate: {
            videoMessage: message.videoMessage,
            hydratedContentText: text,
            hydratedFooterText: footer,
            hydratedButtons: but,
          },
        },
      }),
      options
    );
    A17.relayMessage(jid, template.message, { messageId: template.key.id });
  };
  //send5butmsg
  A17.send5ButMsg = (jid, text = "", footer = "", but = []) => {
    let templateButtons = but;
    var templateMessage = {
      text: text,
      footer: footer,
      templateButtons: templateButtons,
    };
    A17.sendMessage(jid, templateMessage);
  };

  A17.sendFile = async (jid, PATH, fileName, quoted = {}, options = {}) => {
    let types = await A17.getFile(PATH, true);
    let { filename, size, ext, mime, data } = types;
    let type = "",
      mimetype = mime,
      pathFile = filename;
    if (options.asDocument) type = "document";
    if (options.asSticker || /webp/.test(mime)) {
      let { writeExif } = require("./lib/sticker.js");
      let media = { mimetype: mime, data };
      pathFile = await writeExif(media, {
        packname: global.packname,
        author: global.packname,
        categories: options.categories ? options.categories : [],
      });
      await fs.promises.unlink(filename);
      type = "sticker";
      mimetype = "image/webp";
    } else if (/image/.test(mime)) type = "image";
    else if (/video/.test(mime)) type = "video";
    else if (/audio/.test(mime)) type = "audio";
    else type = "document";
    await A17.sendMessage(
      jid,
      { [type]: { url: pathFile }, mimetype, fileName, ...options },
      { quoted, ...options }
    );
    return fs.promises.unlink(pathFile);
  };
  A17.parseMention = async (text) => {
    return [...text.matchAll(/@([0-9]{5,16}|0)/g)].map(
      (v) => v[1] + "@s.whatsapp.net"
    );
  };

  return A17;
}

startA17();

process.on('uncaughtException', function (err) {
let e = String(err)
if (e.includes("Socket connection timeout")) return
if (e.includes("not-authorized")) return
if (e.includes("already-exists")) return
if (e.includes("rate-overlimit")) return
if (e.includes("Connection Closed")) return
if (e.includes("Timed Out")) return
if (e.includes("Value not found")) return
console.log('Caught exception: ', err)
})

let file = require.resolve(__filename);
fs.watchFile(file, () => {
  fs.unwatchFile(file);
  console.log(chalk.redBright(`${__filename} Updated`));
  delete require.cache[file];
  require(file);
});
