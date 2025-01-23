[33mcommit af4a2d126b59e01f60460bb11a67fa3f9ce091ca[m[33m ([m[1;36mHEAD[m[33m -> [m[1;32mmaster[m[33m)[m
Author: Roneri314 <aletrar2002@gmail.com>
Date:   Thu Jan 23 17:50:22 2025 +0200

    The Project for fun

[33mcommit 397411f5fb1a4d20edf88f376806587eae1ec319[m
Author: Roneri314 <aletrar2002@gmail.com>
Date:   Thu Jan 23 14:07:21 2025 +0200

    'Whatsapp'

[1mdiff --git a/Assets/pic1.jpg b/Assets/pic1.jpg[m
[1mnew file mode 100644[m
[1mindex 0000000..5d50e4a[m
Binary files /dev/null and b/Assets/pic1.jpg differ
[1mdiff --git a/Assets/pic3.jpg b/Assets/pic3.jpg[m
[1mnew file mode 100644[m
[1mindex 0000000..e49afb6[m
Binary files /dev/null and b/Assets/pic3.jpg differ
[1mdiff --git a/Assets/pic4.jpg b/Assets/pic4.jpg[m
[1mnew file mode 100644[m
[1mindex 0000000..4887205[m
Binary files /dev/null and b/Assets/pic4.jpg differ
[1mdiff --git a/Assets/pic5.jpg b/Assets/pic5.jpg[m
[1mnew file mode 100644[m
[1mindex 0000000..c1ba42e[m
Binary files /dev/null and b/Assets/pic5.jpg differ
[1mdiff --git a/Assets/pic6.jpg b/Assets/pic6.jpg[m
[1mnew file mode 100644[m
[1mindex 0000000..4266e9a[m
Binary files /dev/null and b/Assets/pic6.jpg differ
[1mdiff --git a/Assets/pic7.jpg b/Assets/pic7.jpg[m
[1mnew file mode 100644[m
[1mindex 0000000..d80a47d[m
Binary files /dev/null and b/Assets/pic7.jpg differ
[1mdiff --git a/Assets/pic9.jpg b/Assets/pic9.jpg[m
[1mnew file mode 100644[m
[1mindex 0000000..1f255ff[m
Binary files /dev/null and b/Assets/pic9.jpg differ
[1mdiff --git a/Core.js b/Core.js[m
[1mnew file mode 100644[m
[1mindex 0000000..4d21053[m
[1m--- /dev/null[m
[1m+++ b/Core.js[m
[36m@@ -0,0 +1,7682 @@[m
[32m+[m[32mprocess.on("uncaughtException", console.error);[m
[32m+[m[32mrequire("./config");[m
[32m+[m[32mconst fs = require('fs');[m
[32m+[m[32mconst pm2 = require('pm2');[m
[32m+[m[32mconst util = require("util");[m
[32m+[m[32mconst { promisify } = require('util');[m
[32m+[m[32mconst setTimeoutPromise = promisify(setTimeout);[m
[32m+[m[32mconst chalk = require("chalk");[m
[32m+[m[32mconst axios = require('axios');[m
[32m+[m[32mconst sharp = require('sharp');[m
[32m+[m[32mconst { spawn, exec, execSync } = require("child_process");[m
[32m+[m[32mconst moment = require("moment-timezone");[m
[32m+[m[32mconst { EmojiAPI } = require("emoji-api");[m
[32m+[m[32mconst { addBalance } = require("./lib/limit.js");[m
[32m+[m[32mconst { smsg, formatp, tanggal, GIFBufferToVideoBuffer, formatDate, getTime, isUrl, sleep, clockString, runtime, fetchJson, getBuffer, jsonformat, format, parseMention, getRandom, fetchBuffer } = require('./lib/myfunc')[m
[32m+[m[32mconst _ = require("lodash");[m
[32m+[m[32mconst yargs = require("yargs/yargs");[m
[32m+[m[32mconst kaitime = moment.tz('Asia/Kolkata').format('HH:mm:ss');[m
[32m+[m[32mconst kaidate = moment.tz('Asia/Kolkata').format('DD/MM/YYYY');[m
[32m+[m[32mconst time2 = moment().tz('Asia/Kolkata').format('HH:mm:ss');[m
[32m+[m[32mconst currentDate = new Date();[m
[32m+[m[32mconst options = { weekday: 'long' }; // Specify 'long' to get the full day name[m
[32m+[m[32mconst currentDay = new Intl.DateTimeFormat('en-US', options).format(currentDate);[m
[32m+[m
[32m+[m[32mconst speed = require('performance-now');[m
[32m+[m[32mconst eco = require('discord-mongoose-economy');[m
[32m+[m[32mconst thiccysapi = require('textmaker-thiccy');[m
[32m+[m[32m// const ffmpeg = require('fluent-ffmpeg');[m
[32m+[m[32m// const ffmpegPath = require('ffmpeg-static').path;[m
[32m+[m[32m// ffmpeg.setFfmpegPath(ffmpegPath);[m
[32m+[m[32mconst maker = require('mumaker');[m
[32m+[m[32mconst Jimp = require('jimp');  // for full dp etc.[m
[32m+[m[32mconst modapk = require("tod-api");[m
[32m+[m[32mconst { hentai } = require('./lib/scraper2.js');[m
[32m+[m[32mconst { instadl } = require('./lib/instadl');[m
[32m+[m[32mconst ty = eco.connect('mongodb+srv://Arch:1t6l2G0r6nagLlOb@cluster0.gedh4.mongodb.net/?retryWrites=true&w=majority');[m
[32m+[m[32mconst { isLimit, limitAdd, getLimit, giveLimit, kurangBalance, getBalance, isGame, gameAdd, givegame, cekGLimit } = require('./lib/limit.js');[m
[32m+[m[32mconst githubstalk = require('./lib/githubstalk');[m
[32m+[m[32mlet { covid } = require('./lib/covid.js');[m
[32m+[m[32mconst { Gempa } = require("./lib/gempa.js");[m
[32m+[m
[32m+[m[32mconst spaceemojis = ["🌌", "🌠", "🚀", "🪐", "🌟"];     // list of emojis for Space CMDs.[m
[32m+[m[32mconst manyemojis = ["😄", "👍", "👏", "👌", "🥇", "🌟", "🎉", "🙌", "🤩", "💯", "🔥", "✨", "🚀", "💖", "🌈", "🌞", "🌠", "🌼", "💪", "😎", "💫", "💓", "🎈", "🎁", "🍾", "🎊", "🥳", "👑", "🌺", "🌻", "🌸"];[m
[32m+[m[32mconst os = require('os');       // for os info[m
[32m+[m
[32m+[m[32mconst gis = require("g-i-s");[m
[32m+[m[32mconst { MessageType } = require('@whiskeysockets/baileys');[m
[32m+[m[32mconst {[m
[32m+[m[32m  FajarNews,[m
[32m+[m[32m  BBCNews,[m
[32m+[m[32m  metroNews,[m
[32m+[m[32m  CNNNews,[m
[32m+[m[32m  iNews,[m
[32m+[m[32m  KumparanNews,[m
[32m+[m[32m  TribunNews,[m
[32m+[m[32m  DailyNews,[m
[32m+[m[32m  DetikNews,[m
[32m+[m[32m  OkezoneNews,[m
[32m+[m[32m  CNBCNews,[m
[32m+[m[32m  KompasNews,[m
[32m+[m[32m  SindoNews,[m
[32m+[m[32m  TempoNews,[m
[32m+[m[32m  IndozoneNews,[m
[32m+[m[32m  AntaraNews,[m
[32m+[m[32m  RepublikaNews,[m
[32m+[m[32m  VivaNews,[m
[32m+[m[32m  KontanNews,[m
[32m+[m[32m  MerdekaNews,[m
[32m+[m[32m  KomikuSearch,[m
[32m+[m[32m  AniPlanetSearch,[m
[32m+[m[32m  KomikFoxSearch,[m
[32m+[m[32m  KomikStationSearch,[m
[32m+[m[32m  MangakuSearch,[m
[32m+[m[32m  KiryuuSearch,[m
[32m+[m[32m  KissMangaSearch,[m
[32m+[m[32m  KlikMangaSearch,[m
[32m+[m[32m  PalingMurah,[m
[32m+[m[32m  LayarKaca21,[m
[32m+[m[32m  AminoApps,[m
[32m+[m[32m  Mangatoon,[m
[32m+[m[32m  WAModsSearch,[m
[32m+[m[32m  Emojis,[m
[32m+[m[32m  CoronaInfo,[m
[32m+[m[32m  JalanTikusMeme,[m
[32m+[m[32m  Cerpen,[m
[32m+[m[32m  Quotes,[m
[32m+[m[32m  Couples,[m
[32m+[m[32m  Darkjokes[m
[32m+[m[32m} = require("dhn-api");[m
[32m+[m[32m//"parse-ms": "^1.1.0",[m
[32m+[m
[32m+[m
[32m+[m
[32m+[m[32m//[m
[32m+[m[32mif (time2 < "23:59:00") {[m
[32m+[m
[32m+[m[32m  var nowtime = 'Good night 🌌'[m
[32m+[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32mif (time2 < "19:00:00") {[m
[32m+[m
[32m+[m[32m  var nowtime = 'Good afternoon 🌆'[m
[32m+[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32mif (time2 < "18:00:00") {[m
[32m+[m
[32m+[m[32m  var nowtime = 'Good afternoon 🌇'[m
[32m+[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32mif (time2 < "15:00:00") {[m
[32m+[m
[32m+[m[32m  var nowtime = 'Good afternoon 🏞'[m
[32m+[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32mif (time2 < "11:00:00") {[m
[32m+[m
[32m+[m[32m  var nowtime = 'Good morning 🌅'[m
[32m+[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32mif (time2 < "05:00:00") {[m
[32m+[m
[32m+[m[32m  var nowtime = 'Good night 🏙'[m
[32m+[m
[32m+[m[32m}[m
[32m+[m
[32m+[m
[32m+[m
[32m+[m[32m//[m
[32m+[m[32mconst timestampe = speed();[m
[32m+[m[32mconst latensie = speed() - timestampe[m
[32m+[m
[32m+[m[32mvar low;[m
[32m+[m[32mtry {[m
[32m+[m[32m  low = require("lowdb");[m
[32m+[m[32m} catch (e) {[m
[32m+[m[32m  low = require("./lib/lowdb");[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32mconst { Low, JSONFile } = low;[m
[32m+[m[32mconst mongoDB = require("./lib/mongoDB");[m
[32m+[m
[32m+[m[32mglobal.opts = new Object([m
[32m+[m[32m  yargs(process.argv.slice(2)).exitProcess(false).parse()[m
[32m+[m[32m);[m
[32m+[m[32mglobal.db = new Low([m
[32m+[m[32m  /https?:\/\//.test(opts["db"] || "")[m
[32m+[m[32m    ? new cloudDBAdapter(opts["db"])[m
[32m+[m[32m    : /mongodb/.test(opts["db"])[m
[32m+[m[32m      ? new mongoDB(opts["db"])[m
[32m+[m[32m      : new JSONFile(`src/database.json`)[m
[32m+[m[32m);[m
[32m+[m[32mglobal.DATABASE = global.db; // Backwards Compatibility[m
[32m+[m[32mglobal.loadDatabase = async function loadDatabase() {[m
[32m+[m[32m  if (global.db.READ)[m
[32m+[m[32m    return new Promise((resolve) =>[m
[32m+[m[32m      setInterval(function () {[m
[32m+[m[32m        !global.db.READ[m
[32m+[m[32m          ? (clearInterval(this),[m
[32m+[m[32m            resolve([m
[32m+[m[32m              global.db.data == null ? global.loadDatabase() : global.db.data[m
[32m+[m[32m            ))[m
[32m+[m[32m          : null;[m
[32m+[m[32m      }, 1 * 1000)[m
[32m+[m[32m    );[m
[32m+[m[32m  if (global.db.data !== null) return;[m
[32m+[m[32m  global.db.READ = true;[m
[32m+[m[32m  await global.db.read();[m
[32m+[m[32m  global.db.READ = false;[m
[32m+[m[32m  global.db.data = {[m
[32m+[m[32m    users: {},[m
[32m+[m[32m    chats: {},[m
[32m+[m[32m    database: {},[m
[32m+[m[32m    game: {},[m
[32m+[m[32m    settings: {},[m
[32m+[m[32m    others: {},[m
[32m+[m[32m    sticker: {},[m
[32m+[m[32m    ...(global.db.data || {}),[m
[32m+[m[32m  };[m
[32m+[m[32m  global.db.chain = _.chain(global.db.data);[m
[32m+[m[32m};[m
[32m+[m[32mloadDatabase();[m
[32m+[m[32mglobal.db = JSON.parse(fs.readFileSync("./src/database.json"));[m
[32m+[m[32mif (global.db)[m
[32m+[m[32m  global.db = {[m
[32m+[m[32m    sticker: {},[m
[32m+[m[32m    database: {},[m
[32m+[m[32m    game: {},[m
[32m+[m[32m    others: {},[m
[32m+[m[32m    users: {},[m
[32m+[m[32m    ...(global.db || {}),[m
[32m+[m[32m  };[m
[32m+[m
[32m+[m
[32m+[m
[32m+[m[32m//[m
[32m+[m[32mlet isSleeping = false; // Move the declaration here.[m
[32m+[m[32mlet banUser = JSON.parse(fs.readFileSync('./database/banUser.json'));[m
[32m+[m[32mlet banchat = JSON.parse(fs.readFileSync('./database/banChat.json'));[m
[32m+[m[32mlet kaiaudio = JSON.parse(fs.readFileSync('./Media-Database/audio.json'));[m
[32m+[m[32mlet _limit = JSON.parse(fs.readFileSync('./storage/user/limit.json'));[m
[32m+[m[32mlet _buruan = JSON.parse(fs.readFileSync('./storage/user/bounty.json'));[m
[32m+[m[32mlet _darahOrg = JSON.parse(fs.readFileSync('./storage/user/blood.json'))[m
[32m+[m[32mlet ntnsfw = JSON.parse(fs.readFileSync('./database/nsfw.json')); //[m
[32m+[m[32mlet pendaftar = JSON.parse(fs.readFileSync('./storage/user/user.json'))[m
[32m+[m[32mlet balance = JSON.parse(fs.readFileSync('./database/balance.json'))[m
[32m+[m[32mlet ssewa = JSON.parse(fs.readFileSync('./database/sewa.json'))[m
[32m+[m[32mlet ban = JSON.parse(fs.readFileSync('./database/ban.json'))[m
[32m+[m[32mlet autosticker = JSON.parse(fs.readFileSync('./database/autosticker.json'))[m
[32m+[m[32mconst _autostick = JSON.parse(fs.readFileSync('./database/autostickpc.json'))[m
[32m+[m[32mlet limit = JSON.parse(fs.readFileSync('./database/limit.json'))[m
[32m+[m[32mlet setik = JSON.parse(fs.readFileSync('./src/sticker.json'))[m
[32m+[m[32mlet vien = JSON.parse(fs.readFileSync('./src/audio.json'))[m
[32m+[m[32mlet imagi = JSON.parse(fs.readFileSync('./src/image.json'))[m
[32m+[m[32mlet videox = JSON.parse(fs.readFileSync('./src/video.json'))[m
[32m+[m[32mglobal.db = JSON.parse(fs.readFileSync('./src/database.json'))[m
[32m+[m[32mlet _sewa = require("./lib/sewa");[m
[32m+[m[32mconst sewa = JSON.parse(fs.readFileSync('./database/sewa.json'))[m
[32m+[m[32mconst time = moment.tz('Asia/Kolkata').format('DD/MM HH:mm:ss')[m
[32m+[m[32mconst ucap = moment(Date.now()).tz('Asia/Kolkata').locale('id').format('a')[m
[32m+[m[32mvar buln = ['/01/', '/02/', '/03/', '/04/', '/05/', '/06/', '/07/', '/08/', '/09/', '/10/', '/11/', '/12/'];[m
[32m+[m[32mvar myHari = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];[m
[32m+[m[32mvar tgel = new Date();[m
[32m+[m[32mvar hri = tgel.getDate();[m
[32m+[m[32mvar bulnh = tgel.getMonth();[m
[32m+[m[32mvar thisHari = tgel.getDay(),[m
[32m+[m[32m  thisDaye = myHari[thisHari];[m
[32m+[m[32mvar yye = tgel.getYear();[m
[32m+[m[32mvar syear = (yye < 1000) ? yye + 1900 : yye;[m
[32m+[m[32mconst jangwak = (hri + '' + buln[bulnh] + '' + syear)[m
[32m+[m[32mconst janghar = (thisDaye)[m
[32m+[m[32mvar myHari = [[m
[32m+[m[32m  "Sunday",[m
[32m+[m[32m  "Monday",[m
[32m+[m[32m  "Tuesday",[m
[32m+[m[32m  "Wednesday",[m
[32m+[m[32m  "Thursday",[m
[32m+[m[32m  "Friday",[m
[32m+[m[32m  "Saturday",[m
[32m+[m[32m];[m
[32m+[m[32mvar tgel = new Date();[m
[32m+[m[32mvar thisHari = tgel.getDay(),[m
[32m+[m[32m  thisDaye = myHari[thisHari];[m
[32m+[m[32mvar yye = tgel.getYear();[m
[32m+[m
[32m+[m
[32m+[m
[32m+[m[32m//[m
[32m+[m[32mmodule.exports = A17 = async (A17, m, chatUpdate, store) => {[m
[32m+[m[32m  try {[m
[32m+[m[32m    var body = (m.mtype === 'conversation') ? m.message.conversation : (m.mtype == 'imageMessage') ? m.message.imageMessage.caption : (m.mtype == 'videoMessage') ? m.message.videoMessage.caption : (m.mtype == 'extendedTextMessage') ? m.message.extendedTextMessage.text : (m.mtype == 'buttonsResponseMessage') ? m.message.buttonsResponseMessage.selectedButtonId : (m.mtype == 'listResponseMessage') ? m.message.listResponseMessage.singleSelectreply.selectedRowId : (m.mtype == 'templateButtonreplyMessage') ? m.message.templateButtonreplyMessage.selectedId : (m.mtype === 'messageContextInfo') ? (m.message.buttonsResponseMessage?.selectedButtonId || m.message.listResponseMessage?.singleSelectreply.selectedRowId || m.text) : ''[m
[32m+[m[32m    var budy = (typeof m.text == 'string' ? m.text : '')[m
[32m+[m[32m    const prefix = global.prefa[m
[32m+[m[32m    const isCmd = body.startsWith(prefix)[m
[32m+[m[32m    const notCmd = body.startsWith('')[m
[32m+[m[32m    const command = isCmd ? body.slice(1).trim().split(' ')[0].toLowerCase() : ''[m
[32m+[m[32m    const args = body.trim().split(/ +/).slice(1)[m
[32m+[m[32m    const pushname = m.pushName || "No Name"[m
[32m+[m[32m    const botNumber = await A17.decodeJid(A17.user.id)[m
[32m+[m[32m    const isCreator = [botNumber, ...global.Owner].map(v => v.replace(/[^0-9]/g, '') + '@s.whatsapp.net').includes(m.sender)[m
[32m+[m[32m    const isyuki = [botNumber, ...global.yukio].map(v => v.replace(/[^0-9]/g, '') + '@s.whatsapp.net').includes(m.sender)[m
[32m+[m[32m    const itsMe = m.sender == botNumber ? true : false[m
[32m+[m[32m    const text = args.join(" ")[m
[32m+[m[32m    const from = m.chat[m
[32m+[m[32m    const quoted = m.quoted ? m.quoted : m[m
[32m+[m[32m    const mime = (quoted.msg || quoted).mimetype || ''[m
[32m+[m[32m    const isMedia = /image|video|sticker|audio/.test(mime)[m
[32m+[m[32m    const messagesD = body.slice(0).trim().split(/ +/).shift().toLowerCase()[m
[32m+[m[32m    const groupMetadata = m.isGroup ? await A17.groupMetadata(m.chat).catch(e => { }) : ''[m
[32m+[m[32m    const groupName = m.isGroup ? groupMetadata.subject : ''[m
[32m+[m[32m    const participants = m.isGroup ? await groupMetadata.participants : ''[m
[32m+[m[32m    const groupAdmins = m.isGroup ? await participants.filter(v => v.admin !== null).map(v => v.id) : ''[m
[32m+[m[32m    const groupOwner = m.isGroup ? groupMetadata.owner : ''[m
[32m+[m[32m    const isBotAdmins = m.isGroup ? groupAdmins.includes(botNumber) : false[m
[32m+[m[32m    const isAdmins = m.isGroup ? groupAdmins.includes(m.sender) : false[m
[32m+[m[32m    const isUser = pendaftar.includes(m.sender)[m
[32m+[m[32m    const isBan = banUser.includes(m.sender)[m
[32m+[m[32m    const welcm = m.isGroup ? wlcm.includes(from) : false[m
[32m+[m[32m    const isBanChat = m.isGroup ? banchat.includes(from) : false[m
[32m+[m[32m    const isRakyat = isCreator || global.rkyt.map(v => v.replace(/[^0-9]/g, '') + '@s.whatsapp.net').includes(m.sender) || false[m
[32m+[m[32m    const AntiLink = m.isGroup ? ntilink.includes(from) : false[m
[32m+[m[32m    const AntiLinkYoutubeVid = m.isGroup ? ntilinkytvid.includes(from) : false[m
[32m+[m[32m    const AntiLinkYoutubeChannel = m.isGroup ? ntilinkytch.includes(from) : false[m
[32m+[m[32m    const AntiLinkInstagram = m.isGroup ? ntilinkig.includes(from) : false[m
[32m+[m[32m    const AntiLinkFacebook = m.isGroup ? ntilinkfb.includes(from) : false[m
[32m+[m[32m    const AntiLinkTiktok = m.isGroup ? ntilinktt.includes(from) : false[m
[32m+[m[32m    const AntiLinkTelegram = m.isGroup ? ntilinktg.includes(from) : false[m
[32m+[m[32m    const AntiLinkTwitter = m.isGroup ? ntilinktwt.includes(from) : false[m
[32m+[m[32m    const AntiLinkAll = m.isGroup ? ntilinkall.includes(from) : false[m
[32m+[m[32m    const antiWame = m.isGroup ? ntwame.includes(from) : false[m
[32m+[m[32m    const antiVirtex = m.isGroup ? ntvirtex.includes(from) : false[m
[32m+[m[32m    const AntiNsfw = m.isGroup ? ntnsfw.includes(from) : false[m
[32m+[m[32m    autoreadsw = true[m
[32m+[m[32m    const content = JSON.stringify(m.message)[m
[32m+[m[32m    const q = args.join(' ')[m
[32m+[m
[32m+[m[32m    const isQuotedVideo = m.mtype === 'extendedTextMessage' && content.includes('videoMessage')[m
[32m+[m[32m    const isQuotedAudio = m.mtype === 'extendedTextMessage' && content.includes('audioMessage')[m
[32m+[m
[32m+[m
[32m+[m
[32m+[m[32m    autoreadsw = true;[m
[32m+[m[32m    _sewa.expiredCheck(A17, sewa);[m
[32m+[m
[32m+[m[32m    const reply = (teks) => {[m
[32m+[m[32m      A17.sendMessage(m.chat, { text: teks }, { quoted: m })[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m
[32m+[m[32m    /* const reply = (teks) => {[m
[32m+[m[32m      A17.sendMessage(m.chat, { text: teks }, { quoted: m });[m[41m [m
[32m+[m[32m    }; */[m
[32m+[m
[32m+[m
[32m+[m[32m    const sender = m.isGroup ? (m.key.participant ? m.key.participant : m.participant) : m.key.remoteJid[m
[32m+[m[32m    const senderNumber = sender.split('@')[0][m
[32m+[m
[32m+[m[32m    function randomNomor(angka) {[m
[32m+[m[32m      return Math.floor(Math.random() * angka) + 1;[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    if (m.message) {[m
[32m+[m[32m      addBalance(m.sender, randomNomor(574), balance);[m
[32m+[m[32m      console.log([m
[32m+[m[32m        chalk.black(chalk.bgWhite("[ MESSAGE ]")),[m
[32m+[m[32m        chalk.black(chalk.bgGreen(new Date())),[m
[32m+[m[32m        chalk.black(chalk.bgBlue(budy || m.mtype)) +[m
[32m+[m[32m        "\n" +[m
[32m+[m[32m        chalk.magenta("=> From"),[m
[32m+[m[32m        chalk.green(pushname),[m
[32m+[m[32m        chalk.yellow(m.sender) + "\n" + chalk.blueBright("=> In"),[m
[32m+[m[32m        chalk.green(m.isGroup ? pushname : "Private Chat", m.chat)[m
[32m+[m[32m      );[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    if (isCmd && !isUser) {[m
[32m+[m[32m      pendaftar.push(m.sender);[m
[32m+[m[32m      fs.writeFileSync("./storage/user/user.json", JSON.stringify(pendaftar));[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m
[32m+[m
[32m+[m[32m    //----------------------------------------------------------------------------------------------------------//[m
[32m+[m
[32m+[m
[32m+[m
[32m+[m[32m    // if (global.autoreadpmngc) {[m
[32m+[m[32m    //   if (command) {[m
[32m+[m[32m    //     await A17.sendPresenceUpdate("composing", m.chat);[m
[32m+[m[32m    //     A17.sendReadReceipt(from, m.sender, [m.key.id]);[m
[32m+[m[32m    //   }[m
[32m+[m[32m    // }[m
[32m+[m
[32m+[m
[32m+[m[32m    //[m
[32m+[m[32m    //   if (global.autoReadGc) {[m
[32m+[m[32m    //   if (m.isGroup) {[m[41m [m
[32m+[m[32m    //       A17.sendReadReceipt(m.chat, m.sender, [m.key.id]);[m
[32m+[m[32m    //   }[m
[32m+[m[32m    // }[m
[32m+[m
[32m+[m
[32m+[m[32m    // if (global.autoReadAll) {[m
[32m+[m[32m    //   if (m.chat) {[m
[32m+[m[32m    //     A17.sendReadReceipt(m.chat, m.sender, [m.key.id]);[m
[32m+[m[32m    //   }[m
[32m+[m[32m    // }[m
[32m+[m
[32m+[m
[32m+[m[32m    if (global.autoreadgc) {[m
[32m+[m[32m      if (command) {[m
[32m+[m[32m        await A17.sendPresenceUpdate('composing', m.chat);[m
[32m+[m
[32m+[m[32m        // Create an array of message keys to mark as read[m
[32m+[m[32m        const keysToMarkAsRead = [[m
[32m+[m[32m          {[m
[32m+[m[32m            remoteJid: m.chat,[m
[32m+[m[32m            id: m.key.id,[m
[32m+[m[32m            participant: m.sender,[m
[32m+[m[32m          },[m
[32m+[m[32m          // You can add more message keys to mark multiple messages as read[m
[32m+[m[32m        ];[m
[32m+[m
[32m+[m[32m        // Use the sock object to read the specified messages[m
[32m+[m[32m        await A17.readMessages(keysToMarkAsRead);[m
[32m+[m[32m      }[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m
[32m+[m[32m    if (global.autoRecord) {[m
[32m+[m[32m      if (m.chat) {[m
[32m+[m[32m        A17.sendPresenceUpdate("recording", m.chat);[m
[32m+[m[32m      }[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    if (global.autoTyping) {[m
[32m+[m[32m      if (m.chat) {[m
[32m+[m[32m        A17.sendPresenceUpdate("composing", m.chat);[m
[32m+[m[32m      }[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    if (global.available) {[m
[32m+[m[32m      if (m.chat) {[m
[32m+[m[32m        A17.sendPresenceUpdate("available", m.chat);[m
[32m+[m[32m      }[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m
[32m+[m
[32m+[m[32m    //Dm and Groups Autoreply/Bot chat[m
[32m+[m[32m    if (!isCmd && !isyuki && !m.isGroup){[m
[32m+[m[32m       const botreply = await axios.get(`https://skizo.tech/api/cai/chat?apikey=Sora&characterId=RAj3vm_xQVvcApJ4BFosLkOQ8O6osGz5E-K5dn9l2xE&sessionId=JbrrgeFQqFcIvnrnJae6z7k2oV9EjgAuvyKitlZCU6g&token=529e24b4173b29dbc3054fef02a380e1e5b41949&text=${encodeURIComponent(budy)}`)[m
[32m+[m[32m        menggoda = `${botreply.data.result.text}`[m
[32m+[m[32m        m.reply(menggoda)[m
[32m+[m[32m     }[m
[32m+[m
[32m+[m
[32m+[m[32m    //----------------------------------------------------------------------------------------------------//[m
[32m+[m
[32m+[m
[32m+[m
[32m+[m[32m    //[m
[32m+[m[32m    for (let anju of kaiaudio) {[m
[32m+[m[32m      if (budy === anju) {[m
[32m+[m[32m        result = fs.readFileSync(`./Assets/audio/${anju}.mp3`)[m
[32m+[m[32m        A17.sendMessage(m.chat, { audio: result, mimetype: 'audio/mp4', ptt: true }, { quoted: m })[m
[32m+[m[32m      }[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m
[32m+[m
[32m+[m[32m    //[m
[32m+[m[32m    // const hariRaya = new Date("6 1, 2022 00:00:00");[m
[32m+[m[32m    // const sekarang = new Date().getTime();[m
[32m+[m[32m    // const Selisih = hariRaya - sekarang;[m
[32m+[m[32m    // const jhari = Math.floor(Selisih / (1000 * 60 * 60 * 24));[m
[32m+[m[32m    // const jjam = Math.floor([m
[32m+[m[32m    //   (Selisih % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60)[m
[32m+[m[32m    // );[m
[32m+[m[32m    // const mmmenit = Math.floor((Selisih % (1000 * 60 * 60)) / (1000 * 60));[m
[32m+[m[32m    // const ddetik = Math.floor((Selisih % (1000 * 60)) / 1000);[m
[32m+[m[32m    // const ultah = `${jhari}Day ${jjam}Hour ${mmmenit}Minute ${ddetik}Second`;[m
[32m+[m
[32m+[m[32m    // async function hitungmundur(bulan, tanggal) {[m
[32m+[m[32m    //   let from = new Date(`${bulan} ${tanggal}, 2022 00:00:00`).getTime();[m
[32m+[m[32m    //   let now = Date.now();[m
[32m+[m[32m    //   let distance = from - now;[m
[32m+[m[32m    //   let days = Math.floor(distance / (1000 * 60 * 60 * 24));[m
[32m+[m[32m    //   let hours = Math.floor([m
[32m+[m[32m    //     (distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60)[m
[32m+[m[32m    //   );[m
[32m+[m[32m    //   let minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));[m
[32m+[m[32m    //   let seconds = Math.floor((distance % (1000 * 60)) / 1000);[m
[32m+[m[32m    //   return ([m
[32m+[m[32m    //     days +[m
[32m+[m[32m    //     "Day " +[m
[32m+[m[32m    //     hours +[m
[32m+[m[32m    //     "Hour " +[m
[32m+[m[32m    //     minutes +[m
[32m+[m[32m    //     "Minute " +[m
[32m+[m[32m    //     seconds +[m
[32m+[m[32m    //     "Second"[m
[32m+[m[32m    //   );[m
[32m+[m[32m    // }[m
[32m+[m
[32m+[m
[32m+[m
[32m+[m[32m    //-----------------------------------------------------------------------------------------------------------------------------------//[m
[32m+[m
[32m+[m
[32m+[m[32m    //don't edit this part.[m
[32m+[m[32m    const formatTime = (seconds) => {[m
[32m+[m[32m      const hours = Math.floor(seconds / 3600);[m
[32m+[m[32m      const minutes = Math.floor((seconds % 3600) / 60);[m
[32m+[m[32m      const secs = seconds % 60;[m
[32m+[m[32m      return `${hours.toString().padStart(2, '0')}:${minutes.toString().padStart(2, '0')}:${secs.toString().padStart(2, '0')}`;[m
[32m+[m[32m    };[m
[32m+[m
[32m+[m[32m    function updateStatus() {[m
[32m+[m[32m      const uptimeInSeconds = Math.floor(process.uptime());[m
[32m+[m[32m      const uptimeFormatted = formatTime(uptimeInSeconds);[m
[32m+[m
[32m+[m[32m      // const status = `[m
[32m+[m[32m      // ㅤㅤ〄ㅤㅤ〘 my name is yuki, your little assistant *-*〙ㅤㅤ〄ㅤㅤㅤㅤ[m
[32m+[m[32m      // ㅤㅤㅤ〘ㅤ Auto Uptime: ${uptimeFormatted}ㅤ〙`;[m
[32m+[m
[32m+[m[32m      function _0x582b(_0xabb6f8, _0x12cdd8) { const _0x58e890 = _0x58e8(); return _0x582b = function (_0x582b90, _0x4387b3) { _0x582b90 = _0x582b90 - 0x189; let _0x932613 = _0x58e890[_0x582b90]; return _0x932613; }, _0x582b(_0xabb6f8, _0x12cdd8); } function _0x58e8() { const _0x109554 = ['12896370RDSmnX', '3BgvPel', '189HbmdoW', '18854HvEPNh', '11TZHUID', '9125326EcyeIg', '464328lPaAMf', '3400722cbWEOK', '2263175KIczdo', '12TaHNqM', '2521564eqJRHK']; _0x58e8 = function () { return _0x109554; }; return _0x58e8(); } (function (_0x429d7b, _0x532ab5) { const _0x527567 = _0x582b, _0x130eb4 = _0x429d7b(); while (!![]) { try { const _0x75c57a = -parseInt(_0x527567(0x18b)) / 0x1 + -parseInt(_0x527567(0x192)) / 0x2 * (-parseInt(_0x527567(0x189)) / 0x3) + parseInt(_0x527567(0x191)) / 0x4 * (-parseInt(_0x527567(0x190)) / 0x5) + -parseInt(_0x527567(0x18f)) / 0x6 + parseInt(_0x527567(0x18d)) / 0x7 + parseInt(_0x527567(0x18e)) / 0x8 * (-parseInt(_0x527567(0x18a)) / 0x9) + parseInt(_0x527567(0x193)) / 0xa * (parseInt(_0x527567(0x18c)) / 0xb); if (_0x75c57a === _0x532ab5) break; else _0x130eb4['push'](_0x130eb4['shift']()); } catch (_0x19ea04) { _0x130eb4['push'](_0x130eb4['shift']()); } } }(_0x58e8, 0xa8dae)); const status = '\x0a\x20\x20ㅤㅤ〄ㅤㅤ〘\x20YUKI\x20GLOBAL\x20Edition BY TRAMA\x20〙ㅤㅤ〄ㅤㅤㅤㅤ\x0a\x20\x20ㅤㅤㅤ〘ㅤ\x20Auto\x20Uptime:\x20' + uptimeFormatted + 'ㅤ〙';[m
[32m+[m
[32m+[m[32m      A17.setStatus(status); // Set the status using A17.setStatus or your equivalent method[m
[32m+[m
[32m+[m[32m      // Update the status randomly within 5 minutes (300000 milliseconds)[m
[32m+[m[32m      const randomTime = Math.floor(Math.random() * 300000) + 1000; // don't edit.[m
[32m+[m[32m      setTimeout(updateStatus, randomTime);[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    // Initial call to start the random status updates[m
[32m+[m[32m    updateStatus();[m
[32m+[m
[32m+[m
[32m+[m
[32m+[m[32m    //-----------------------------------------------------------------------------------------------------------------------------------//[m
[32m+[m
[32m+[m
[32m+[m
[32m+[m[32m    //[m
[32m+[m[32m    // if (AntiLinkAll)[m
[32m+[m[32m    //   var rondonxk = '[-a-zA-Z0-9@:%._+~#=].[-a-zA-Z0-9@:%._+~#=].[-a-zA-Z0-9()@:%_+.~#?&/=]'[m
[32m+[m[32m    //   if (budy.includes("https://")) {[m
[32m+[m[32m    //     if (!isBotAdmins) return[m
[32m+[m[32m    //     bvl = `\`\`\`「  Antilink System  」\`\`\`\n\nLink sent by Admin so no action will be taken!`[m
[32m+[m[32m    //     if (isAdmins) return reply(bvl)[m
[32m+[m[32m    //     if (m.key.fromMe) return reply(bvl)[m
[32m+[m[32m    //     if (isCreator) return reply(bvl)[m
[32m+[m[32m    //     kice = m.sender[m
[32m+[m[32m    //     await A17.sendMessage([m
[32m+[m[32m    //       from,[m
[32m+[m[32m    //       {[m
[32m+[m[32m    //         delete: {[m
[32m+[m[32m    //           remoteJid: from,[m
[32m+[m[32m    //           fromMe: false,[m
[32m+[m[32m    //           id: m.id,[m
[32m+[m[32m    //           participant: m.sender,[m
[32m+[m[32m    //         },[m
[32m+[m[32m    //       },[m
[32m+[m[32m    //       {[m
[32m+[m[32m    //         quoted: m,[m
[32m+[m[32m    //       }[m
[32m+[m[32m    //     );[m
[32m+[m[32m    //   //  await A17.groupParticipantsUpdate(m.chat, [kice], 'remove')[m
[32m+[m[32m    //     A17.sendMessage(from, { text: `\`\`\`「  Antilink System  」\`\`\`\n\n*⚠️ Group link detected !*\n\n*🚫@${kice.split("@")[0]} You are not allowed to send any links in this group !*\n`, contextInfo: { mentionedJid: [kice] } }, { quoted: m })[m
[32m+[m[32m    //   } else {[m
[32m+[m[32m    //   }[m
[32m+[m
[32m+[m[32m    // if (budy.includes("http://")) {[m
[32m+[m[32m    //     if (!isBotAdmins) return[m
[32m+[m[32m    //     bvl = `\`\`\`「  Antilink System  」\`\`\`\n\nLink sent by Admin so no action will be taken!`[m
[32m+[m[32m    //     if (isAdmins) return reply(bvl)[m
[32m+[m[32m    //     if (m.key.fromMe) return reply(bvl)[m
[32m+[m[32m    //     if (isCreator) return reply(bvl)[m
[32m+[m[32m    //     kice = m.sender[m
[32m+[m[32m    //     await A17.sendMessage([m
[32m+[m[32m    //       from,[m
[32m+[m[32m    //       {[m
[32m+[m[32m    //         delete: {[m
[32m+[m[32m    //           remoteJid: from,[m
[32m+[m[32m    //           fromMe: false,[m
[32m+[m[32m    //           id: m.id,[m
[32m+[m[32m    //           participant: m.sender,[m
[32m+[m[32m    //         },[m
[32m+[m[32m    //       },[m
[32m+[m[32m    //       {[m
[32m+[m[32m    //         quoted: m,[m
[32m+[m[32m    //       }[m
[32m+[m[32m    //     );[m
[32m+[m[32m    //   //  await A17.groupParticipantsUpdate(m.chat, [kice], 'remove')[m
[32m+[m[32m    //     A17.sendMessage(from, { text: `\`\`\`「  Antilink System  」\`\`\`\n\n*⚠️ Group link detected !*\n\n*🚫@${kice.split("@")[0]} You are not allowed to send any links in this group !*\n`, contextInfo: { mentionedJid: [kice] } }, { quoted: m })[m
[32m+[m[32m    //   } else {[m
[32m+[m[32m    //   }[m
[32m+[m
[32m+[m
[32m+[m[32m    //     const menulist = `[m
[32m+[m[32m    //     Konichiwa ${pushname} dear 👋. I am ${global.BotName}, a bot developed by: Kai to take your WhatsApp usage into next level.[m
[32m+[m
[32m+[m[32m    //        「 System Info 」[m
[32m+[m
[32m+[m[32m    //     Speed : ${latensie.toFixed(4)} miliseconds[m
[32m+[m[32m    //     Up Time : ${runtime(process.uptime())}[m
[32m+[m[32m    //     Bot Name : ${global.BotName}[m
[32m+[m[32m    //     Owner Name : ${global.OwnerName}[m
[32m+[m[32m    //     𝗣𝗹𝗮𝘁𝗳𝗼𝗿𝗺 : Amazon AWS[m
[32m+[m[32m    //     𝗧𝗼𝘁𝗮𝗹 𝗨𝘀𝗲𝗿 : ${Object.keys(global.db.users).length}[m
[32m+[m
[32m+[m
[32m+[m[32m    //        「 User Info 」[m
[32m+[m
[32m+[m[32m    //     User Level: ${levelMenu}[m
[32m+[m[32m    //     User XP : ${xpMenu} \ ${reqXp}[m
[32m+[m[32m    //     User Role : ${role}[m
[32m+[m
[32m+[m
[32m+[m[32m    //        「 User Bank 」[m
[32m+[m
[32m+[m[32m    //     User Balance : ${uangku}[m
[32m+[m[32m    //    //Iron : ${getBesi(m.sender)}[m
[32m+[m[32m    //     Gold : ${getEmas(m.sender)}[m
[32m+[m[32m    //     Emarald : ${getEmerald(m.sender)}[m
[32m+[m[32m    //     Potion : ${getPotion(m.sender)}[m
[32m+[m
[32m+[m
[32m+[m[32m    //     Type *-menu* or press any button below to start using *${global.BotName}*[m
[32m+[m
[32m+[m[32m    //     ©️ *${global.BotName}* All Rights Reserved by: *Kai*[m
[32m+[m[32m    //     `[m
[32m+[m[32m    //         const qtod = m.quoted? "true":"false"[m
[32m+[m
[32m+[m
[32m+[m
[32m+[m[32m    // function pickRandom(list) {[m
[32m+[m[32m    // return list[Math.floor(list.length * Math.random())][m
[32m+[m[32m    // }[m
[32m+[m
[32m+[m
[32m+[m
[32m+[m[32m    //-------------------------------------------------------------- tictactoe ----------------------------------------------------------------//[m
[32m+[m
[32m+[m
[32m+[m[32m    //[m
[32m+[m[32m    this.game = this.game ? this.game : {}[m
[32m+[m[32m    let room = Object.values(this.game).find(room => room.id && room.game && room.state && room.id.startsWith('tictactoe') && [room.game.playerX, room.game.playerO].includes(m.sender) && room.state == 'PLAYING')[m
[32m+[m[32m    if (room) {[m
[32m+[m[32m      let ok[m
[32m+[m[32m      let isWin = !1[m
[32m+[m[32m      let isTie = !1[m
[32m+[m[32m      let isSurrender = !1[m
[32m+[m[32m      //reply(`[DEBUG]\n${parseInt(m.text)}`)[m
[32m+[m[32m      if (!/^([1-9]|(me)?give up|surr?ender|off|skip)$/i.test(m.text)) return[m
[32m+[m[32m      isSurrender = !/^[1-9]$/.test(m.text)[m
[32m+[m[32m      if (m.sender !== room.game.currentTurn) {[m
[32m+[m[32m        if (!isSurrender) return !0[m
[32m+[m[32m      }[m
[32m+[m[32m      if (!isSurrender && 1 > (ok = room.game.turn(m.sender === room.game.playerO, parseInt(m.text) - 1))) {[m
[32m+[m[32m        reply({[m
[32m+[m[32m          '-3': 'Game Has Ended',[m
[32m+[m[32m          '-2': 'Invalid',[m
[32m+[m[32m          '-1': 'Invalid Position',[m
[32m+[m[32m          0: 'Invalid Position',[m
[32m+[m[32m        }[ok])[m
[32m+[m[32m        return !0[m
[32m+[m[32m      }[m
[32m+[m[32m      if (m.sender === room.game.winner) isWin = true[m
[32m+[m[32m      else if (room.game.board === 511) isTie = true[m
[32m+[m[32m      let arr = room.game.render().map(v => {[m
[32m+[m[32m        return {[m
[32m+[m[32m          X: '❌',[m
[32m+[m[32m          O: '⭕',[m
[32m+[m[32m          1: '1️⃣',[m
[32m+[m[32m          2: '2️⃣',[m
[32m+[m[32m          3: '3️⃣',[m
[32m+[m[32m          4: '4️⃣',[m
[32m+[m[32m          5: '5️⃣',[m
[32m+[m[32m          6: '6️⃣',[m
[32m+[m[32m          7: '7️⃣',[m
[32m+[m[32m          8: '8️⃣',[m
[32m+[m[32m          9: '9️⃣',[m
[32m+[m[32m        }[v][m
[32m+[m[32m      })[m
[32m+[m[32m      if (isSurrender) {[m
[32m+[m[32m        room.game._currentTurn = m.sender === room.game.playerX[m
[32m+[m[32m        isWin = true[m
[32m+[m[32m      }[m
[32m+[m[32m      let winner = isSurrender ? room.game.currentTurn : room.game.winner[m
[32m+[m[32m      let str = `Room ID: ${room.id}[m
[32m+[m[32m${arr.slice(0, 3).join('')}[m
[32m+[m[32m${arr.slice(3, 6).join('')}[m
[32m+[m[32m${arr.slice(6).join('')}[m
[32m+[m[32m${isWin ? `@${winner.split('@')[0]} Won!` : isTie ? `Game Over` : `Turn ${['❌', '⭕'][1 * room.game._currentTurn]} (@${room.game.currentTurn.split('@')[0]})`}[m
[32m+[m[32m❌: @${room.game.playerX.split('@')[0]}[m
[32m+[m[32m⭕: @${room.game.playerO.split('@')[0]}[m
[32m+[m[32mTyped *surrender* to surrender and admited defeat`[m
[32m+[m[32m      if ((room.game._currentTurn ^ isSurrender ? room.x : room.o) !== m.chat)[m
[32m+[m[32m        room[room.game._currentTurn ^ isSurrender ? 'x' : 'o'] = m.chat[m
[32m+[m[32m      if (room.x !== room.o) await A17.sendText(room.x, str, m, { mentions: parseMention(str) })[m
[32m+[m[32m      await A17.sendText(room.o, str, m, { mentions: parseMention(str) })[m
[32m+[m[32m      if (isTie || isWin) {[m
[32m+[m[32m        delete this.game[room.id][m
[32m+[m[32m      }[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m
[32m+[m[32m    //-----------------------------------------------------------------------------------------------------------------------------------//[m
[32m+[m
[32m+[m
[32m+[m[32m    //[m
[32m+[m[32m    const pickRandom = (arr) => {[m
[32m+[m[32m      return arr[Math.floor(Math.random() * arr.length)][m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    /*[m
[32m+[m[32m  let smallinput = budy.toLowerCase()[m
[32m+[m[32m  if (smallinput.includes('hello')) {[m
[32m+[m[32m    reply (`Hello ${pushname}, I am ${BotName}. How can i help you?`);[m
[32m+[m[32m  }[m[41m [m
[32m+[m[41m  [m
[32m+[m[32m  //if (smallinput.includes('hi')) {[m
[32m+[m[41m  [m
[32m+[m[32m  //   reply (`Hello ${pushname}, I am ${BotName}. How can i help you?`);[m
[32m+[m[41m  [m
[32m+[m[32m  // }[m[41m [m
[32m+[m[41m  [m
[32m+[m[32m  if (smallinput=='kai') {[m
[32m+[m[32m      reply (`My Boss is lost in another Multiverse, and I lost the connection with him...`)[m
[32m+[m[32m  }[m
[32m+[m[41m  [m
[32m+[m[41m  [m
[32m+[m[32m  if (smallinput=='runtime') {[m
[32m+[m[32m    reply (`Hey ${pushname} my runtime is ${runtime(process.uptime())}\n\nCurrent Time: ${kaitime}\n\nCurrent Date: ${kaidate}`)[m
[32m+[m[32m  }[m
[32m+[m[41m  [m
[32m+[m[41m  [m
[32m+[m[41m  [m
[32m+[m[32m  if( smallinput.includes('konichiwa') || smallinput.includes('konochiwa') || smallinput.includes('konichiba') || smallinput.includes('salute')){[m
[32m+[m[32m    reply (`Konichiwa ${pushname}, I am ${BotName}. How can i help you?`);[m
[32m+[m[32m  }[m
[32m+[m[41m  [m
[32m+[m[41m  [m
[32m+[m[32m  if (smallinput=='a17') {[m
[32m+[m[32m      reply ('Yes I am Alive 🫂')[m
[32m+[m[32m  }[m
[32m+[m[41m  [m
[32m+[m[32m  if (smallinput=='sasha') {[m
[32m+[m[32m    reply ('Only you...🫶🏻')[m
[32m+[m[32m  }[m
[32m+[m[41m  [m
[32m+[m[32m  if (smallinput=='ping') {[m
[32m+[m[32m      reply (`Hey ${pushname} Pong ${latensie.toFixed(4)} ms`)[m
[32m+[m[32m  }[m
[32m+[m[41m  [m
[32m+[m[41m  [m
[32m+[m[32m  if (smallinput.includes('good morning') || smallinput.includes('ohayo')) {[m
[32m+[m[32m    reply (`Good morning to you too ${pushname} ☺️. Have a great day 😇.`);[m
[32m+[m[32m  }[m
[32m+[m[41m  [m
[32m+[m[32m  if (smallinput.includes('good afternoon') || smallinput.includes('konnichiwa')) {[m
[32m+[m[41m  [m
[32m+[m[32m    reply (`Good afthernoon to you too ${pushname} ✨. Wishing you an enjoyable afternoon too 😇🤞🏻.`);[m
[32m+[m[41m  [m
[32m+[m[32m  }[m
[32m+[m[41m  [m
[32m+[m[41m  [m
[32m+[m[32m  //if (smallinput.includes('good afthernoon')) {[m
[32m+[m[32m   // reply (`Huh ${pushname} 😇. Wishing you an enjoyable afternoon too.`);[m
[32m+[m[32m  //   }[m
[32m+[m[41m  [m
[32m+[m[41m  [m
[32m+[m[32m  if (smallinput.includes('good night')) {[m
[32m+[m[32m    reply (`Good night to you too ${pushname} 😇. Sleep well and sweet dreams.`);[m
[32m+[m[32m  }[m
[32m+[m[41m  [m
[32m+[m[32m  if (smallinput.includes('arigato')|| smallinput.includes('arigatou') || smallinput.includes('thank')) {[m
[32m+[m[32m    reply (`Mention not ${pushname} 😇. I am a bot afterall.`);[m
[32m+[m[32m  }[m
[32m+[m[32m  */[m
[32m+[m
[32m+[m
[32m+[m[32m    const responses = {[m
[32m+[m
[32m+[m
[32m+[m[32m      hello: `Hello ${pushname}, I am ${BotName}. My current prefix is "${prefix}". How can I help you?`,[m
[32m+[m[32m      'trama': `My Boss is lost in another Multiverse, and I lost connection with him...`,[m
[32m+[m[32m      runtime: `Hey ${pushname}\n${nowtime}\n\nMy runtime:${runtime(process.uptime())}\n\nPrefix is: *${prefix}*\n\nTime: ${kaitime}\n\nDate: ${kaidate}\n\nToday is ${currentDay}`,[m
[32m+[m[32m      konichiwa: `Konichiwa ${pushname}, I am ${BotName}. How can I help you?`,[m
[32m+[m[32m      sasha: 'Only you...🫶🏻',[m
[32m+[m[32m      ping: `Hey ${pushname}, Pong ${latensie.toFixed(4)} ms`,[m
[32m+[m[32m      'good morning': `Good morning to you too ${pushname} ☺️. Have a great day 😇.`,[m
[32m+[m[32m      ohayo: `Good morning to you too ${pushname} ☺️. Have a great day 😇.`,[m
[32m+[m[32m      'good afternoon': `Good afternoon to you too ${pushname} ✨. Wishing you an enjoyable afternoon too 😇🤞🏻.`,[m
[32m+[m[32m      konnichiwa: `Good afternoon to you too ${pushname} ✨. Wishing you an enjoyable afternoon too 😇🤞🏻.`,[m
[32m+[m[32m      'good night': `Good night to you too ${pushname} 😇. Sleep well and sweet dreams.`,[m[41m [m
[32m+[m	[32m'هجهج' : '❄️⚡️🔥🌟 هجهج ستار ملك الأفكار',[m
[32m+[m	[32m    'تستس' : 'يويو',[m
[32m+[m[32m    };[m
[32m+[m
[32m+[m[32m    const smallinput = budy.toLowerCase();[m
[32m+[m
[32m+[m[32m    if (responses.hasOwnProperty(smallinput)) {[m
[32m+[m[32m      reply(responses[smallinput]);[m
[32m+[m[32m    }[m
[32m+[m[41m	  [m
[32m+[m[32mif (smallinput==('يوكي')) {[m
[32m+[m[32m      if (isBan) return reply(`آسفة بس انت محظور من البوت`);[m
[32m+[m[32m      if (!isyuki) {[m
[32m+[m[32m  const typ = ['عيون يوكي',[m
[32m+[m[32m   'احكي',[m
[32m+[m[32m    'عيوني' ,[m
[32m+[m[32m     'عايز حاجة؟' ,[m
[32m+[m[32m     'أهلييين' ,[m[41m [m
[32m+[m[32m     'ديشاااك حبيبنا ياخ',[m
[32m+[m[32m    'وين يا ز9999لي',[m
[32m+[m[32m    'جمبك',[m
[32m+[m[32m    'اللمور و الصحة',[m
[32m+[m[32m    'اللخبار',[m
[32m+[m[32m    'رايك شنو في الاسم الجميل دا',[m
[32m+[m[32m     'الدنيا ضلام ما سامعاك'];[m
[32m+[m[32m  const random = typ[Math.floor(Math.random() * typ.length)];[m
[32m+[m[32m  reply(random)[m
[32m+[m[32m  }[m
[32m+[m	[32m}[m
[32m+[m
[32m+[m[41m    [m
[32m+[m[32mif (smallinput.includes('البوت') || smallinput.includes('بوتة')){[m
[32m+[m[32m      if (isBan) return reply(`آسفة بس انت محظور من البوت`);[m
[32m+[m[32m      if (!isyuki) {[m
[32m+[m[32m  const typ = ['عندي اسم يا شاب', 'ناديني ب اسمي لو سمحت',[m
[32m+[m[32m   'للمرة ال100 اسمي يوكييي ياخ' ,[m
[32m+[m[32m   'بوت مرتك , اه نسيت ما عندك مرا يا وحيد' ,[m[41m [m
[32m+[m[32m  'ممكن عادي تسألني من اسمي ما باكل انا...' ,[m
[32m+[m[32m   'كلمة بوت بتجرح مشاعري ممكن تناديني ب اسمي؟' ,[m[41m [m
[32m+[m[32m  'بمشيها ليك المرة دي بس ، اها مالك',[m
[32m+[m[32m'call me بوت one more time i dare u!',[m
[32m+[m[32m'اليوم كلو بوت بوت ، قديتنا قد',[m
[32m+[m[32m'يا زول ما تشوف شغلتك',[m
[32m+[m[32m'الواحد يبرمجوه و يضبحو بايثون في سمايته ، يجي زول يناديه بوت',[m
[32m+[m[32m'خلاص انا بوت عرفنا',[m
[32m+[m[32m'عيون البوت'];[m
[32m+[m[32m  const random = typ[Math.floor(Math.random() * typ.length)];[m
[32m+[m[32m  reply(random)[m
[32m+[m[32m      }[m
[32m+[m	[32m}[m
[32m+[m
[32m+[m
[32m+[m[32m   if (smallinput.includes('تست')) {[m
[32m+[m[32m    let media = await getBuffer("https://mallucampaign.in/images/img_1710704094.jpg");[m
[32m+[m[32m          const webpBuffer = await sharp(media)[m
[32m+[m[32m         .webp({ animated: true }) // Set animated to true for animated stickers[m
[32m+[m[32m         .toBuffer();[m
[32m+[m[32m       // Send sticker using A17 library (replace with your actual function)[m
[32m+[m[32m       A17.sendMessage(from, { sticker: webpBuffer }, { quoted: m });[m[41m  [m
[32m+[m[32m   }[m
[32m+[m
[32m+[m
[32m+[m	[32m  if (smallinput.includes('سست')) {[m
[32m+[m[32m    let media = await getBuffer("https://gifdb.com/images/thumbnail/ghost-hug-virtual-kiss-anime-girl-menhera-chan-c3fvyxsyb034zqbt.gif");[m
[32m+[m[32m          const webpBuffer = await sharp(media)[m
[32m+[m[32m         .webp({ animated: true }) // Set animated to true for animated stickers[m
[32m+[m[32m         .toBuffer();[m
[32m+[m[32m       // Send sticker using A17 library (replace with your actual function)[m
[32m+[m[32m       A17.sendMessage(from, { sticker: webpBuffer }, { quoted: m });[m[41m  [m
[32m+[m[32m   }[m
[32m+[m[32m    //-----------------------------------------------------------------------------------------------------------------------------------//[m
[32m+[m
[32m+[m
[32m+[m
[32m+[m[32m    if (smallinput.includes('يوكي') || smallinput.includes('yuki') || smallinput.includes('بوت')) {[m
[32m+[m[32m      if (isBan) return reply(`آسفة بس انت محظور من البوت`);[m
[32m+[m[32m      if (!isyuki) {[m
[32m+[m[32m            // قائمة بروابط الصور المختلفة[m
[32m+[m[32m           const imageUrls = [ '',[m
[32m+[m[32m           'https://graph.org/file/00359404498976bb12de0.png',[m
[32m+[m[32m           'https://graph.org/file/68b1fe1310122d9e101a2.png',[m
[32m+[m[32m           'https://graph.org/file/96b97f6a983e91405108b.png',[m
[32m+[m[32m           'https://graph.org/file/e6a9b9c34d8f8a9815ec0.png'[m
[32m+[m[32m           'https://graph.org/file/5aa9c778c5462118a2e5a.png',[m
[32m+[m[32m           'https://graph.org/file/31f355914a558a5cac385.png',[m
[32m+[m[32m           'https://graph.org/file/ebdd2092ac5eebdf6c241.png',[m
[32m+[m[32m           'https://graph.org/file/42f08ec5bffa52ddcd5a7.png',[m
[32m+[m[32m           'https://graph.org/file/9cf9514a107b7da263db1.png',[m
[32m+[m[32m           'https://graph.org/file/7f862d96e99fb24780e7f.png',[m
[32m+[m[32m           'https://graph.org/file/d169b9ae86bacaf6dc1a7.png',[m
[32m+[m[32m           'https://graph.org/file/cbf21d0319006bd8fcbaa.png',[m
[32m+[m[32m           'https://graph.org/file/322e856993e524d390f0f.png',[m
[32m+[m[32m           'https://graph.org/file/05ec47da60f9427de5e0e.png',[m
[32m+[m[32m           'https://graph.org/file/820ab928174bcb86c9c3f.png',[m
[32m+[m[32m           'https://graph.org/file/696c6e9280fa467335937.png',[m
[32m+[m[32m           'https://graph.org/file/78bde4815154d19b06d2d.png',[m
[32m+[m[32m           'https://graph.org/file/0b64c74ce6113baec3a33.png'[m
[32m+[m[41m        [m
[32m+[m[32m            ];[m
[32m+[m[41m        [m
[32m+[m[32m            // اختيار رابط عشوائي[m
[32m+[m[32m            const randomImageUrl = imageUrls[Math.floor(Math.random() * imageUrls.length)];[m
[32m+[m[32m                let media = await getBuffer(randomImageUrl);[m
[32m+[m[32m                const webpBuffer = await sharp(media)[m
[32m+[m[32m                 .webp()[m[41m [m
[32m+[m[32m                 .toBuffer();[m
[32m+[m[32m               // Send sticker usng A17 libray (replace with your actual function)[m
[32m+[m[32m               A17.sendMessage(from, { sticker: webpBuffer }, { quoted: m });[m[41m   [m
[32m+[m[32m           }[m
[32m+[m[32m             }[m
[32m+[m
[32m+[m[32m    //[m
[32m+[m	[32m  //[m[41m  [m
[32m+[m	[32m       // CYPHER 1.0[m
[32m+[m
[32m+[m[32mif (smallinput==('اسمك منو')) {[m
[32m+[m[32m      if (isBan) return reply(`آسفة بس انت محظور من البوت`);[m
[32m+[m[32m      if (!isyuki) {[m
[32m+[m[32m  const typ = ['اسمي يوكينا' , 'أبيت ما بوريك' , 'مالك و مالو' , 'اسمي يوكي'];[m
[32m+[m[32m  const random = typ[Math.floor(Math.random() * typ.length)];[m
[32m+[m[32m  reply(random)[m
[32m+[m[32m  }[m
[32m+[m	[32m}[m
[32m+[m
[32m+[m[32mif (smallinput.includes('🤣🤣') || smallinput.includes('😂😂')){[m
[32m+[m[32m      if (!isyuki) {[m
[32m+[m[32m  const typ = ['ضحكة لكن' , 'تتفصل كدا تقول ترزي' , 'هيهيهي وزعنا بلح جاك عجوة؟' , 'الضحكة دي الياها الخلت حميدتي يقلب البلد' , 'ارجل شوية' , 'دي ضحكة ليك مع الرجال؟' , 'كتكت يا بطة' , 'ضحكتك دي جابتني من الكلاكلة'];[m
[32m+[m[32m  const random = typ[Math.floor(Math.random() * typ.length)];[m
[32m+[m[32m  reply(random)[m
[32m+[m[32m      }[m
[32m+[m	[32m}[m[41m	  [m
[32m+[m
[32m+[m[32mif (smallinput.includes('كيفك') || smallinput.includes('اخبارك') || smallinput.includes('امورك')) {[m
[32m+[m[32m      if (isBan) return reply(`آسفة بس انت محظور من البوت`);[m
[32m+[m[32m      if (!isyuki) {[m
[32m+[m[32m  const typ = ['انا تمام الحمدلله ، انت كيف؟' , 'تمام زهجانة بس' , 'مالك و مالي' , 'انت كيفي و خبري و اموري يا عسل' , 'زهج بس يا زولي' , 'بخير دامك بخير'];[m
[32m+[m[32m  const random = typ[Math.floor(Math.random() * typ.length)];[m
[32m+[m[32m  reply(random)[m
[32m+[m[32m      }[m
[32m+[m	[32m}[m[41m	 [m
[32m+[m
[32m+[m[32m  // Jokes NOT aside :o[m[41m [m
[32m+[m
[32m+[m[32m  if (smallinput.includes('نكتة') || smallinput.includes('نكته'){[m
[32m+[m[32m    if (isBan) return reply(`آسفة بس انت محظور من البوت`);[m
[32m+[m[32m    if (!isyuki) {[m
[32m+[m[32mconst typ = [[m
[32m+[m[32m'واحد خيالو واسع اتملص منو😆' ,[m
[32m+[m[32m'واحد عمل ليه شاي  تقيل م قدر يشيلو😆' ,[m
[32m+[m[32m'واحد جاب شعرو بالجمبه عشان كان دايرو في موضوع😆',[m
[32m+[m[32m'واحد اسمو حسن نجيلة  نسى الباب فاتح الغنماية دخلت اكلت ابوه😆',[m
[32m+[m[32m'واحد كراعو خدرت وداها المشتل😆',[m
[32m+[m[32m'مره واحد اسمه احمد عماره داير ينتحر نط من فوق ابوه😆',[m
[32m+[m[32m'واحدة شعرها ناعم ختتو ف شياله😆',[m
[32m+[m[32m'واحد رجع في كلامه عفصو😆',[m
[32m+[m[32m'ضابط مرور عرس ضابطة جابو اولاد بتكلمو بالاشارات😆',[m
[32m+[m[32m'واحد اسمو سامح خت يدو في اضانو بقا م سامح😆',[m
[32m+[m[32m'استاذ عربي وقع رفعوه بالضمه😆',[m
[32m+[m[32m'واحده اسمها اسرار ضربتها عربيه الشارع اتملا فضايح😆',[m
[32m+[m[32m'مسطول داير يقطع الزلط لقى السكينه ميته😆',[m
[32m+[m[32m'واحده اسمها بسمه كبرت بقت توقيع😆',[m
[32m+[m[32m'مره مدير عام ومدير غرق😆',[m
[32m+[m[32m'واحد عرس صينيه شال فيها الاكل😆',[m
[32m+[m[32m'استاذ رياضيات طقتو ركشه فات المستشفى قالو ليهو عندك كسور قاليهم وحدو المقامات😆',[m
[32m+[m[32m'مسطول عرف انو الشيطان شاطر فات يراجع معاه حسبان',[m
[32m+[m[32m'واحد رجلينو رقاق اتسحر بيهم😆',[m
[32m+[m[32m'واحدة اسمها رنين غابت عن الدوام سجلوها مكالمه فائته😆',[m
[32m+[m[32m'واحد عيونو صغار دخلهم الروضه😆',[m
[32m+[m[32m    ];[m
[32m+[m[32mconst random = typ[Math.floor(Math.random() * typ.length)];[m
[32m+[m[32mreply(random)[m
[32m+[m[32m    }[m
[32m+[m[32m}[m
[32m+[m
[32m+[m
[32m+[m
[32m+[m
[32m+[m	[32m  //[m
[32m+[m	[32m  //[m
[32m+[m[32m    //[m
[32m+[m	[32m  // CYPHER ENDS HERE[m
[32m+[m[41m	  [m
[32m+[m[32m    switch (command) {[m
[32m+[m
[32m+[m
[32m+[m[32m      //[m
[32m+[m[32m      case 'sc': case 'script': case 'sourcecode': {[m
[32m+[m[32m        if (isBan) return reply(mess.banned);[m
[32m+[m[32m        if (isBanChat) return reply(mess.bangc);[m
[32m+[m[32m        A17.sendMessage(from, { react: { text: "❤", key: m.key } })[m
[32m+[m
[32m+[m[32m        let { data } = await axios.get('https://api.github.com/repos/Kai0071/A17');[m
[32m+[m[32m        teks = `*A17 Script*\n\n*Total Stars*: ${data.stargazers_count}⭐\n*Total Forks*: ${data.forks_count} forks\n*GitHub*: https://github.com/Kai0071/A17\n\nDont forget to follow me on *GitHub* and give a ⭐️ to my projects. `[m
[32m+[m[32m        /*  let buttons = [[m
[32m+[m[32m          {buttonId: `${prefix}owner`, buttonText: {displayText: '🍁 DEVELOPER 🍁'}, type: 1}[m
[32m+[m[32m          ] */[m
[32m+[m[32m        let buttonMessage = {[m
[32m+[m[32m          image: Thumb,[m
[32m+[m[32m          jpegThumbnail: BotLogo,[m
[32m+[m[32m          caption: teks,[m
[32m+[m[32m          /* footer: `${BotName}`,[m
[32m+[m[32m           buttons: buttons,[m
[32m+[m[32m           headerType: 4, */[m
[32m+[m[32m          contextInfo: {[m
[32m+[m[32m            externalAdreply: {[m
[32m+[m[32m              title: "Powered by Kai",[m
[32m+[m[32m              body: " ",[m
[32m+[m[32m              thumbnail: fs.readFileSync("Assets/pic2.jpg"),[m
[32m+[m[32m              mediaType: 1,[m
[32m+[m[32m              //mediaUrl: 'https://wallpapercave.com/wp/wp10524580.jpg',[m
[32m+[m[32m              //sourceUrl: "https://wallpapercave.com/wp/wp10524580.jpg"[m
[32m+[m[32m              mediaUrl: 'github.com/Kai0071/A17',[m
[32m+[m[32m              sourceUrl: "github.com/Kai0071/A17"[m
[32m+[m[32m            }[m
[32m+[m[32m          }[m
[32m+[m
[32m+[m[32m        }[m
[32m+[m[32m        A17.sendMessage(m.chat, buttonMessage, { quoted: m })[m
[32m+[m[32m      }[m
[32m+[m[32m        break;[m
[32m+[m
[32m+[m[32m      case 'qt': {[m
[32m+[m[32m        if (!args[0] && !m.quoted) {[m
[32m+[m[32m          return m.reply(`Please provide a text (Type or mention a message) !`);[m
[32m+[m[32m        }[m
[32m+[m
[32m+[m[32m        try {[m
[32m+[m[32m          let userPfp;[m
[32m+[m[32m          if (m.quoted) {[m
[32m+[m[32m            userPfp = await A17.profilePictureUrl(m.quoted.sender, "image");[m
[32m+[m[32m          } else {[m
[32m+[m[32m            userPfp = await A17.profilePictureUrl(m.sender, "image");[m
[32m+[m[32m          }[m
[32m+[m
[32m+[m[32m          const waUserName = pushname;[m
[32m+[m[32m          const quoteText = m.quoted ? m.quoted.body : args.join(" ");[m
[32m+[m
[32m+[m[32m          const quoteJson = {[m
[32m+[m[32m            type: "quote",[m
[32m+[m[32m            format: "png",[m
[32m+[m[32m            backgroundColor: "#FFFFFF",[m
[32m+[m[32m            width: 700,[m
[32m+[m[32m            height: 580,[m
[32m+[m[32m            scale: 2,[m
[32m+[m[32m            messages: [[m
[32m+[m[32m              {[m
[32m+[m[32m                entities: [],[m
[32m+[m[32m                avatar: true,[m
[32m+[m[32m                from: {[m
[32m+[m[32m                  id: 1,[m
[32m+[m[32m                  name: waUserName,[m
[32m+[m[32m                  photo: {[m
[32m+[m[32m                    url: userPfp,[m
[32m+[m[32m                  },[m
[32m+[m[32m                },[m
[32m+[m[32m                text: quoteText,[m
[32m+[m[32m                replyMessage: {},[m
[32m+[m[32m              },[m
[32m+[m[32m            ],[m
[32m+[m[32m          };[m
[32m+[m
[32m+[m[32m          const quoteResponse = await axios.post("https://bot.lyo.su/quote/generate", quoteJson, {[m
[32m+[m[32m            headers: { "Content-Type": "application/json" },[m
[32m+[m[32m          });[m
[32m+[m
[32m+[m[32m          const buffer = Buffer.from(quoteResponse.data.result.image, "base64");[m
[32m+[m[32m          A17.sendImageAsSticker(m.chat, buffer, m, {[m
[32m+[m[32m            packname: `${global.BotName}`,[m
[32m+[m[32m            author: waUserName,[m
[32m+[m[32m          });[m
[32m+[m[32m          const sharp = require('sharp');[m
[32m+[m[32mconst webpBuffer = await sharp(media)[m
[32m+[m[32m         .webp()[m[41m [m
[32m+[m[32m         .toBuffer();[m
[32m+[m
[32m+[m[32m       A17.sendMessage(from, { sticker: webpBuffer }, { quoted: m });[m
[32m+[m[41m            [m
[32m+[m[32m        } catch (error) {[m
[32m+[m[32m          console.error(error);[m
[32m+[m[32m          m.reply("Error generating quote!");[m
[32m+[m[32m        }[m
[32m+[m[32m        break;[m
[32m+[m[32m      }[m
[32m+[m
[32m+[m
[32m+[m
[32m+[m[32m      case 'support': case 'supportgc': {[m
[32m+[m[32m        if (isBan) return reply(mess.banned);[m
[32m+[m[32m        if (isBanChat) return reply(mess.bangc);[m
[32m+[m
[32m+[m[32m        A17.sendMessage(from, { react: { text: "💫", key: m.key } })[m
[32m+[m[32m        reply(`⚙ *My developer's group:* ⚙ https://chat.whatsapp.com/BCUPpF7gKTg6Sx9y2WSIuF`)[m
[32m+[m[32m      }[m
[32m+[m[32m        break;[m
[32m+[m
[32m+[m
[32m+[m[32m      case 'repo': case 'botrepo': {[m
[32m+[m[32m        if (isBan) return reply(mess.banned);[m
[32m+[m[32m        if (isBanChat) return reply(mess.bangc);[m
[32m+[m
[32m+[m[32m        A17.sendMessage(from, { react: { text: "💫", key: m.key } })[m
[32m+[m[32m        reply(`⚙ My Source Code is </> - https://github.com/trama-008/A17`)[m
[32m+[m[32m      }[m
[32m+[m[32m        break;[m
[32m+[m[41m        [m
[32m+[m
[32m+[m[32m      case 'owner': case 'creator': case 'mod': case 'mods': {[m
[32m+[m[32m        if (isBan) return reply(mess.banned);[m
[32m+[m[32m        if (isBanChat) return reply(mess.bangc);[m
[32m+[m
[32m+[m[32m        A17.sendMessage(from, { react: { text: "💫", key: m.key } })[m
[32m+[m[32m        A17.sendContact(m.chat, global.Owner, m)[m
[32m+[m[32m      }[m
[32m+[m[32m        break;[m
[32m+[m
[32m+[m
[32m+[m[32m      case 'addmod':[m
[32m+[m[32m      case 'addowner':[m
[32m+[m[32m        if (isBan) return reply(mess.banned);[m
[32m+[m[32m        if (isBanChat) return reply(mess.bangc);[m
[32m+[m[32m        if (!isCreator) return reply(mess.botowner)[m
[32m+[m[32m        A17.sendMessage(from, { react: { text: "🛡️", key: m.key } })[m
[32m+[m
[32m+[m[32m        if (!args[0]) return reply(`Use ${prefix + command} number\nExample ${prefix + command} ${OwnerNumber}`)[m
[32m+[m[32m        bnnd = q.split("|")[0].replace(/[^0-9]/g, '')[m
[32m+[m[32m        let ceknye = await A17.onWhatsApp(bnnd)[m
[32m+[m[32m        if (ceknye.length == 0) return reply(`Enter A Valid And Registered Number On WhatsApp!!!`)[m
[32m+[m[32m        Owner.push(bnnd)[m
[32m+[m[32m        fs.writeFileSync('./database/mod.json', JSON.stringify(Owner))[m
[32m+[m[32m        reply(`Number ${bnnd} Has Become An Owner!!!`)[m
[32m+[m[32m        break;[m
[32m+[m
[32m+[m
[32m+[m[32m      case 'delowner':[m
[32m+[m[32m      case 'delmod':[m
[32m+[m[32m        if (isBan) return reply(mess.banned);[m
[32m+[m[32m        if (isBanChat) return reply(mess.bangc);[m
[32m+[m[32m        if (!isCreator) return reply(mess.botowner)[m
[32m+[m[32m        A17.sendMessage(from, { react: { text: "🛡️", key: m.key } })[m
[32m+[m
[32m+[m[32m        if (!args[0]) return reply(`Use ${prefix + command} nomor\nExample ${prefix + command} 916297175943`)[m
[32m+[m[32m        ya = q.split("|")[0].replace(/[^0-9]/g, '')[m
[32m+[m[32m        unp = Owner.indexOf(ya)[m
[32m+[m[32m        Owner.splice(unp, 1)[m
[32m+[m[32m        fs.writeFileSync('./database/mod.json', JSON.stringify(Owner))[m
[32m+[m[32m        reply(`The Numbrr ${ya} Has been deleted from owner list by the owner!!!`)[m
[32m+[m[32m        break;[m
[32m+[m
[32m+[m
[32m+[m[32m      case 'modlist':[m
[32m+[m[32m        if (isBan) return reply(mess.banned);[m
[32m+[m[32m        if (isBanChat) return reply(mess.bangc);[m
[32m+[m[32m        if (!isCreator) return reply(mess.botowner);[m
[32m+[m[32m        A17.sendMessage(from, { react: { text: "🛡️", key: m.key } })[m
[32m+[m
[32m+[m[32m        try {[m
[32m+[m[32m          const modData = fs.readFileSync('./database/mod.json', 'utf8');[m
[32m+[m[32m          const mods = JSON.parse(modData);[m
[32m+[m
[32m+[m[32m          if (mods.length === 0) {[m
[32m+[m[32m            reply('There are no mods in the list.');[m
[32m+[m[32m          } else {[m
[32m+[m[32m            let modList = '';[m
[32m+[m
[32m+[m[32m            mods.forEach((mod, index) => {[m
[32m+[m[32m              modList += `(${index + 1}) ${A17.getName(mod)}\n`;[m
[32m+[m[32m            });[m
[32m+[m
[32m+[m[32m            reply(`List of List of Moderators:\n\n${modList}`);[m
[32m+[m[32m          }[m
[32m+[m[32m        } catch (error) {[m
[32m+[m[32m          console.error(error);[m
[32m+[m[32m          reply('Failed to fetch mod list.');[m
[32m+[m[32m        }[m
[32m+[m[32m        break;[m
[32m+[m
[32m+[m
[32m+[m[32m      case 'setbotpp': {[m
[32m+[m
[32m+[m[32m        if (!isCreator) return reply(mess.owner)[m
[32m+[m[32m        if (isBanChat) return reply(mess.bangc);[m
[32m+[m[32m        if (!isCreator) return reply(mess.owner)[m
[32m+[m[32m        A17.sendMessage(from, { react: { text: "🫡", key: m.key } })[m
[32m+[m
[32m+[m[32m        if (!quoted) return `*Send/reply Image With Caption* ${prefix + command}`[m
[32m+[m[32m        if (!/image/.test(mime)) return `*Send/reply Image With Caption* ${prefix + command}`[m
[32m+[m[32m        if (/webp/.test(mime)) return `*Send/reply Image With Caption* ${prefix + command}`[m
[32m+[m[32m        let media = await A17.downloadAndSaveMediaMessage(quoted)[m
[32m+[m[32m        await A17.updateProfilePicture(botNumber, { url: media }).catch((err) => fs.unlinkSync(media))[m
[32m+[m[32m        m.reply(mess.jobdone)[m
[32m+[m[32m      }[m
[32m+[m[32m        break;[m
[32m+[m
[32m+[m
[32m+[m[32m      //[m
[32m+[m[32m      case 'changeprefix':[m
[32m+[m[32m      case 'setprefix':[m
[32m+[m
[32m+[m[32m        if (isBan) return reply(mess.banned);[m
[32m+[m[32m        if (isBanChat) return reply(mess.bangc);[m
[32m+[m[32m        if (!isCreator) return reply(mess.botowner)[m
[32m+[m[32m        A17.sendMessage(from, { react: { text: "🛡️", key: m.key } })[m
[32m+[m
[32m+[m[32m        if (args.length !== 1) {[m
[32m+[m[32m          return m.reply(`Please provide a single character as the new prefix.`);[m
[32m+[m[32m        } else {[m
[32m+[m[32m          const newPrefix = args[0];[m
[32m+[m[32m          try {[m
[32m+[m[32m            global.prefa = [newPrefix];[m
[32m+[m[32m            return m.reply(`${pushname} Successfully changed Prefix to "${newPrefix}"`);[m
[32m+[m[32m          } catch (error) {[m
[32m+[m[32m            console.error('Error changing prefix:', error);[m
[32m+[m[32m            return m.reply(`An error occurred while changing the prefix. Please try again later.`);[m
[32m+[m[32m          }[m
[32m+[m[32m        }[m
[32m+[m
[32m+[m
[32m+[m[32m      //[m
[32m+[m[32m      case 'restart':[m
[32m+[m[32m        await A17.sendMessage(from, { react: { text: "⚙", key: m.key } });[m
[32m+[m[32m        if (!isCreator) return reply(mess.botowner)[m
[32m+[m
[32m+[m[32m        await A17.sendMessage(from, { text: mess.waiting });[m
[32m+[m[32m        await A17.sendMessage(from, { react: { text: "✅", key: m.key } });[m
[32m+[m[32m        await A17.sendMessage(from, { text: 'Restarting Success!' });[m
[32m+[m
[32m+[m[32m        // Delay the shutdown by 5 seconds using sleep function[m
[32m+[m[32m        //await sleep(5000);[m
[32m+[m
[32m+[m[32m        // Use PM2 to restart the script[m
[32m+[m[32m        pm2.restart('index', (err) => {[m
[32m+[m[32m          if (err) {[m
[32m+[m[32m            A17.sendMessage(from, { react: { text: "❌", key: m.key } });[m
[32m+[m[32m            A17.sendMessage(from, { text: 'Restarting Failed!' });[m
[32m+[m[32m          } else {[m
[32m+[m[32m            return;[m
[32m+[m[32m          }[m
[32m+[m[32m        });[m
[32m+[m[32m        break;[m
[32m+[m
[32m+[m
[32m+[m[32m      //[m
[32m+[m[32m      case 'shutdown': case 'sleep':[m
[32m+[m[32m        if (!isCreator) return reply(mess.owner)[m
[32m+[m[32m        if (isBanChat) return reply(mess.bangc);[m
[32m+[m[32m        if (!isCreator) return reply(mess.owner)[m
[32m+[m[32m        await A17.sendMessage(from, { react: { text: "⚠️", key: m.key } })[m
[32m+[m
[32m+[m[32m        reply(`رايحه انام، أوياسمي!`)[m
[32m+[m[32m        await sleep(5000)[m
[32m+[m[32m        process.exit()[m
[32m+[m[32m        break;[m
[32m+[m
[32m+[m
[32m+[m[32m      case 'public': {[m
[32m+[m[32m        if (isBan) return reply(mess.banned);[m
[32m+[m[32m        if (isBanChat) return reply(mess.bangc);[m
[32m+[m[32m        if (!isCreator) return reply(mess.owner)[m
[32m+[m[32m        A17.sendMessage(from, { react: { text: "🫡", key: m.key } })[m
[32m+[m
[32m+[m[32m        A17.public = true[m
[32m+[m[32m        reply('يمكن للجميع استخدامي الان!')[m
[32m+[m[32m        A17.setStatus(`Mode : Public`)[m
[32m+[m[32m      }[m
[32m+[m[32m        break;[m
[32m+[m
[32m+[m
[32m+[m[32m      case 'self': {[m
[32m+[m[32m        if (isBan) return reply(mess.banned);[m
[32m+[m[32m        if (isBanChat) return reply(mess.bangc);[m
[32m+[m[32m        if (!isCreator) return reply(mess.botowner)[m
[32m+[m
[32m+[m[32m        A17.sendMessage(from, { react: { text: "🫡", key: m.key } })[m
[32m+[m[32m        A17.public = false[m
[32m+[m[32m        reply('فقط تراما من يمكنه استخدامي الان!')[m
[32m+[m[32m        A17.setStatus(`Mode : Self`)[m
[32m+[m[32m      }[m
[32m+[m[32m        break;[m
[32m+[m
[32m+[m
[32m+[m[32m      case 'autoreadgc':[m
[32m+[m[32m      case 'auto-read-gc':[m
[32m+[m[32m      case 'readgc':[m
[32m+[m[32m        if (isBan) return reply(mess.banned);[m
[32m+[m[32m        if (isBanChat) return reply(mess.bangc);[m
[32m+[m[32m        if (!isCreator) return reply(mess.botowner);[m
[32m+[m[32m        A17.sendMessage(from, { react: { text: '❤', key: m.key } });[m
[32m+[m
[32m+[m[32m        if (args.length === 0) {[m
[32m+[m[32m          // Display the current status of autoreadgc[m
[32m+[m[32m          return m.reply(`Auto-Read-GC is currently ${global.autoreadgc ? 'enabled' : 'disabled'}.`);[m
[32m+[m[32m        } else if (args.length === 1 && (args[0] === 'on' || args[0] === 'off')) {[m
[32m+[m[32m          const status = args[0];[m
[32m+[m[32m          if (status === 'on') {[m
[32m+[m[32m            global.autoreadgc = true;[m
[32m+[m[32m            return m.reply('Auto-Read-GC is now enabled.');[m
[32m+[m[32m          } else {[m
[32m+[m[32m            global.autoreadgc = false;[m
[32m+[m[32m            return m.reply('Auto-Read-GC is now disabled.');[m
[32m+[m[32m          }[m
[32m+[m[32m        } else {[m
[32m+[m[32m          return m.reply(`Usage: ${global.prefa[0]}autoreadgc [on/off]`);[m
[32m+[m[32m        }[m
[32m+[m[32m        break;[m
[32m+[m
[32m+[m
[32m+[m[32m      case 'autotyping':[m
[32m+[m[32m      case 'auto-typing':[m
[32m+[m
[32m+[m[32m        if (isBan) return reply(mess.banned);[m
[32m+[m[32m        if (isBanChat) return reply(mess.bangc);[m
[32m+[m[32m        if (!isCreator) return reply(mess.botowner)[m
[32m+[m[32m        A17.sendMessage(from, { react: { text: '❤', key: m.key } });[m
[32m+[m
[32m+[m[32m        if (args.length === 0) {[m
[32m+[m[32m          if (global.autoTyping) {[m
[32m+[m[32m            return m.reply(`Auto typing in group chats is currently *enabled*.\n\nTo disable, use \`${global.prefa[0]}autotyping off\`.`);[m
[32m+[m[32m          } else {[m
[32m+[m[32m            return m.reply(`Auto typing in group chats is currently *disabled*.\n\nTo enable, use \`${global.prefa[0]}autotyping on\`.`);[m
[32m+[m[32m          }[m
[32m+[m[32m        } else if (args.length === 1 && (args[0] === 'on' || args[0] === 'off')) {[m
[32m+[m[32m          const status = args[0];[m
[32m+[m[32m          if (status === 'on') {[m
[32m+[m[32m            global.autoTyping = true;[m
[32m+[m[32m            return m.reply(`Auto typing in group chats is now *enabled*.`);[m
[32m+[m[32m          } else {[m
[32m+[m[32m            global.autoTyping = false;[m
[32m+[m[32m            return m.reply(`Auto typing in group chats is now *disabled*.`);[m
[32m+[m[32m          }[m
[32m+[m[32m        } else {[m
[32m+[m[32m          return m.reply(`Usage: \`${global.prefa[0]}autotyping [on/off]\``);[m
[32m+[m[32m        }[m
[32m+[m[32m        break;[m
[32m+[m
[32m+[m
[32m+[m[32m      case 'autorecord':[m
[32m+[m[32m      case 'auto-recording':[m
[32m+[m
[32m+[m[32m        if (isBan) return reply(mess.banned);[m
[32m+[m[32m        if (isBanChat) return reply(mess.bangc);[m
[32m+[m[32m        if (!isCreator) return reply(mess.botowner)[m
[32m+[m[32m        A17.sendMessage(from, { react: { text: '❤', key: m.key } });[m
[32m+[m
[32m+[m[32m        if (args.length === 0) {[m
[32m+[m[32m          if (global.autoRecord) {[m
[32m+[m[32m            return m.reply(`Auto recording is currently *enabled*.\n\nTo disable, use \`${global.prefa[0]}autorecord off\`.`);[m
[32m+[m[32m          } else {[m
[32m+[m[32m            return m.reply(`Auto recording is currently *disabled*.\n\nTo enable, use \`${global.prefa[0]}autorecord on\`.`);[m
[32m+[m[32m          }[m
[32m+[m[32m        } else if (args.length === 1 && (args[0] === 'on' || args[0] === 'off')) {[m
[32m+[m[32m          const status = args[0];[m
[32m+[m[32m          if (status === 'on') {[m
[32m+[m[32m            global.autoRecord = true;[m
[32m+[m[32m            return m.reply(`Auto recording is now *enabled*.`);[m
[32m+[m[32m          } else {[m
[32m+[m[32m            global.autoRecord = false;[m
[32m+[m[32m            return m.reply(`Auto recording is now *disabled*.`);[m
[32m+[m[32m          }[m
[32m+[m[32m        } else {[m
[32m+[m[32m          return m.reply(`Usage: \`${global.prefa[0]}autorecord [on/off]\``);[m
[32m+[m[32m        }[m
[32m+[m[32m        break;[m
[32m+[m
[32m+[m
[32m+[m[32m      //Hosted platfrom info[m
[32m+[m[32m      case 'server':[m
[32m+[m[32m      case 'sysinfo': {[m
[32m+[m[32m        const used = process.memoryUsage();[m
[32m+[m[32m        const cpu = os.cpus()[0];[m
[32m+[m[32m        const totalCpuUsage = (100 * (cpu.times.user + cpu.times.nice + cpu.times.sys + cpu.times.irq) / cpu.times.idle).toFixed(2);[m
[32m+[m[32m        const systemName = os.platform() + ' ' + os.release();[m
[32m+[m
[32m+[m[32m        const respon = `[m
[32m+[m[32m  🤖 *A17's Server Info* 🤖[m
[32m+[m[41m  [m
[32m+[m[32m  *System*: ${systemName}[m
[32m+[m[41m  [m
[32m+[m[32m  *RAM*: ${formatp(os.totalmem() - os.freemem())} / ${formatp(os.totalmem())}[m
[32m+[m[41m  [m
[32m+[m[32m  *NodeJS Memory Usage*: ${Object.keys(used).map(key => `${key}: ${formatp(used[key])}`).join(', ')}[m
[32m+[m[41m  [m
[32m+[m[32m  *Total CPU Usage*: ${totalCpuUsage}%[m
[32m+[m[41m  [m
[32m+[m[32m  *CPU Model*: ${cpu.model.trim()} (${cpu.speed} MHz)[m
[32m+[m[41m  [m
[32m+[m[32m  *Runtime*: ${runtime(process.uptime())}[m
[32m+[m[41m  [m
[32m+[m[32m  *Response Speed*: ${latensie.toFixed(4)} seconds[m
[32m+[m[32m  `.trim();[m
[32m+[m
[32m+[m[32m        m.reply(respon);[m
[32m+[m[32m        break;[m
[32m+[m[32m     }[m[41m [m
[32m+[m
[32m+[m
[32m+[m[32m      case 'autostatus':[m
[32m+[m[32m      case 'auto-status':[m
[32m+[m[32m      case 'statusevent':[m
[32m+[m[32m      case 'autostatusseen':[m
[32m+[m
[32m+[m[32m        if (isBan) return reply(mess.banned);[m
[32m+[m[32m        if (isBanChat) return reply(mess.bangc);[m
[32m+[m[32m        if (!isCreator) return reply(mess.botowner)[m
[32m+[m[32m        A17.sendMessage(from, { react: { text: '❤', key: m.key } });[m
[32m+[m
[32m+[m[32m        if (args.length === 0) {[m
[32m+[m[32m          // Display the current status of autostatus[m
[32m+[m[32m          return m.reply(`Auto-Status is currently ${global.statusseen ? 'enabled' : 'disabled'}.`);[m
[32m+[m[32m        } else if (args.length === 1 && (args[0] === 'on' || args[0] === 'off')) {[m
[32m+[m[32m          const status = args[0];[m
[32m+[m[32m          if (status === 'on') {[m
[32m+[m[32m            global.statusseen = true;[m
[32m+[m[32m            return m.reply('Auto-Status is now enabled.');[m
[32m+[m[32m          } else {[m
[32m+[m[32m            global.statusseen = false;[m
[32m+[m[32m            return m.reply('Auto-Status is now disabled.');[m
[32m+[m[32m          }[m
[32m+[m[32m        } else {[m
[32m+[m[32m          return m.reply(`Usage: ${global.prefa[0]}autostatus [on/off]`);[m
[32m+[m[32m        }[m
[32m+[m[32m        break;[m
[32m+[m
[32m+[m
[32m+[m[32m      case 'ban': {[m
[32m+[m[32m        if (isBan) return reply(mess.banned);[m
[32m+[m[32m        if (isBanChat) return reply(mess.bangc);[m
[32m+[m[32m        if (!isCreator) return reply(mess.botowner)[m
[32m+[m[32m        A17.sendMessage(from, { react: { text: "🫡", key: m.key } })[m
[32m+[m[32m        if (!args[0]) return reply(`Select add or del (add to ban, del to unban), For Example: reply *${prefix}ban add* to the user you want to ban.`)[m
[32m+[m[32m        if (args[1]) {[m
[32m+[m[32m          orgnye = args[1] + "@s.whatsapp.net"[m
[32m+[m[32m        } else if (m.quoted) {[m
[32m+[m[32m          orgnye = m.quoted.sender[m
[32m+[m[32m        }[m
[32m+[m[32m        const isBane = banUser.includes(orgnye)[m
[32m+[m[32m        if (args[0] === "add") {[m
[32m+[m[32m          if (isBane) return ads('User is already banned.')[m
[32m+[m[32m          banUser.push(orgnye)[m
[32m+[m[32m          reply(`Successfully Banned the user.`)[m
[32m+[m[32m        } else if (args[0] === "del") {[m
[32m+[m[32m          if (!isBane) return ads('User is already unbanned.')[m
[32m+[m[32m          let delbans = banUser.indexOf(orgnye)[m
[32m+[m[32m          banUser.splice(delbans, 1)[m
[32m+[m[32m          reply(`Successfully Unbanned the user.`)[m
[32m+[m[32m        } else {[m
[32m+[m[32m          reply("Error")[m
[32m+[m[32m        }[m
[32m+[m[32m      }[m
[32m+[m[32m        break;[m
[32m+[m
[32m+[m
[32m+[m
[32m+[m[32m      //-------------------------------------------------------------------------------------------------------------------------//[m
[32m+[m
[32m+[m
[32m+[m
[32m+[m[32m      //tictactoe game[m
[32m+[m
[32m+[m[32m      case 'ttc': case 'ttt': case 'tictactoe': {[m
[32m+[m[32m        if (isBan) return reply(mess.ban)[m
[32m+[m[32m        if (isBanChat) return reply(mess.banChat)[m
[32m+[m[32m        A17.sendMessage(from, { react: { text: "🎮", key: m.key } })[m
[32m+[m
[32m+[m[32m        let TicTacToe = require("./lib/tictactoe")[m
[32m+[m[32m        this.game = this.game ? this.game : {}[m
[32m+[m[32m        if (Object.values(this.game).find(room => room.id.startsWith('tictactoe') && [room.game.playerX, room.game.playerO].includes(m.sender))) return reply(`${pushname} You Are Still In The Game...`)[m
[32m+[m[32m        let room = Object.values(this.game).find(room => room.state === 'WAITING' && (text ? room.name === text : true))[m
[32m+[m[32m        if (room) {[m
[32m+[m[32m          reply(`Hey ${pushname} Your Partner found!`)[m
[32m+[m[32m          room.o = m.chat[m
[32m+[m[32m          room.game.playerO = m.sender[m
[32m+[m[32m          room.state = 'PLAYING'[m
[32m+[m[32m          let arr = room.game.render().map(v => {[m
[32m+[m[32m            return {[m
[32m+[m[32m              X: '❌',[m
[32m+[m[32m              O: '⭕',[m
[32m+[m[32m              1: '1️⃣',[m
[32m+[m[32m              2: '2️⃣',[m
[32m+[m[32m              3: '3️⃣',[m
[32m+[m[32m              4: '4️⃣',[m
[32m+[m[32m              5: '5️⃣',[m
[32m+[m[32m              6: '6️⃣',[m
[32m+[m[32m              7: '7️⃣',[m
[32m+[m[32m              8: '8️⃣',[m
[32m+[m[32m              9: '9️⃣',[m
[32m+[m[32m            }[v][m
[32m+[m[32m          })[m
[32m+[m[32m          let str = `Room ID: ${room.id}[m
[32m+[m[32m  ${arr.slice(0, 3).join('')}[m
[32m+[m[32m  ${arr.slice(3, 6).join('')}[m
[32m+[m[32m  ${arr.slice(6).join('')}[m
[32m+[m[32m  Waiting @${room.game.currentTurn.split('@')[0]}[m
[32m+[m[32m  Type *surrender* to surrender and admit defeat...`[m
[32m+[m[32m          if (room.x !== room.o) await A17.sendText(room.x, str, m, { mentions: parseMention(str) })[m
[32m+[m[32m          await A17.sendText(room.o, str, m, { mentions: parseMention(str) })[m
[32m+[m[32m        } else {[m
[32m+[m[32m          room = {[m
[32m+[m[32m            id: 'tictactoe-' + (+new Date),[m
[32m+[m[32m            x: m.chat,[m
[32m+[m[32m            o: '',[m
[32m+[m[32m            game: new TicTacToe(m.sender, 'o'),[m
[32m+[m[32m            state: 'WAITING'[m
[32m+[m[32m          }[m
[32m+[m[32m          if (text) room.name = text[m
[32m+[m[32m          reply('Waiting For Partner' + (text ? ` Type The Command Below ${prefix} ${command} ${text}` : ''))[m
[32m+[m[32m          this.game[room.id] = room[m
[32m+[m[32m        }[m
[32m+[m[32m      }[m
[32m+[m[32m        break;[m
[32m+[m
[32m+[m
[32m+[m
[32m+[m[32m      // report and suggest ...[m
[32m+[m
[32m+[m[32m      case 'report': case 'suggest ': {[m
[32m+[m[32m        if (isBan) return reply(mess.banned);[m
[32m+[m[32m        if (isBanChat) return reply(mess.bangc);[m
[32m+[m[32m        if (!text) return reply(`please provide a report message you want to deliver`)[m
[32m+[m[32m        if (text.length > 300) return reply(`Are you trying to send virus!`)[m
[32m+[m[32m        const txtmsg = `*📮 Report Message*\n\n*Sender ➛* wa.me/${m.sender.split("@")[0]}\n\n*Group Name ➛* ${groupName}\n\n*Message ➛*  ${text}`[m
[32m+[m[32m        for (let mod of global.Owner.map(v => v.replace(/[^0-9]/g, '') + '@s.whatsapp.net').filter(v => v != '6297175943@s.whatsapp.net'))[m
[32m+[m[32m          await A17.sendMessage(`${mod}`, { text: `${txtmsg}` }, { quoted: m })[m
[32m+[m[32m        await A17.sendMessage(`120363026915700516@g.us`, { text: `${txtmsg}`, mentions: groupAdmins }, { quoted: m })[m
[32m+[m[32m        reply(`*✅ Your Report has been submitted Successfully to Support group & Owner*\n\n*You will get response shortly... ♥️*`);[m
[32m+[m[32m      }[m
[32m+[m[32m        break;[m
[32m+[m
[32m+[m
[32m+[m
[32m+[m[32m      // economy ...[m
[32m+[m
[32m+[m[32m      case 'daily': case 'claim': case 'reward':[m
[32m+[m
[32m+[m[32m        {[m
[32m+[m[32m          if (m.quoted?.sender) m.mentionedJid.push(m.quoted.sender)[m
[32m+[m[32m          if (isBan) return reply(mess.banned);[m
[32m+[m[32m          if (isBanChat) return reply(mess.bangc);[m
[32m+[m[32m          if (!m.isGroup) return reply(mess.grouponly)[m
[32m+[m
[32m+[m[32m          A17.sendMessage(from, { react: { text: "💰", key: m.key } })[m
[32m+[m[32m          let user = m.sender[m
[32m+[m[32m          const cara = "cara"[m
[32m+[m[32m          const daily = await eco.daily(user, cara, 999); //give 999 for daily,