require("dotenv").config();

const {token} = process.env;
const {Client, Collection, GatewayIntentBits} = require("discord.js");
const FS = require("fs");

const client = new Client({intents: GatewayIntentBits.Guilds});
client.Commands = new Collection();
client.Color = new Collection();
client.CommandArray = [];

const FunctionFolders = FS.readdirSync(`./src/functions`);
for (const folder of FunctionFolders) {
  const FunctionFiles = FS
  .readdirSync(`./src/functions/${folder}`)
  .filter((file) => file.endsWith(".js"));

  for (const file of FunctionFiles)
    require(`./functions/${folder}/${file}`)(client);
}

client.handleCommands();
client.handleEvents();
client.login(token);