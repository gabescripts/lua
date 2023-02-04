const {REST} = require("@discordjs/rest");
const {Routes} = require("discord-api-types/v9");
const FS = require("fs");

module.exports = (client) => {
  client.handleCommands = async() => {
    const CommandFolders = FS.readdirSync("./src/commands");
    
    for (const folder of CommandFolders) {
      const CommandFiles = FS
      .readdirSync(`./src/commands/${folder}`)
      .filter((file) => file.endsWith(".js"));

      const {Commands, CommandArray} = client;
      for (const file of CommandFiles) {
        const Command = require(`../../commands/${folder}/${file}`);
        
        Commands.set(Command.data.name, Command);
        CommandArray.push(Command.data.toJSON());
        console.log(`Command: ${Command.data.name} has been passed through the handler.`);
      }
    }

    const clientId = "1046329184475164673";
    const guildId = "1009015899262570527";
    const rest = new REST({version: "9"}).setToken(process.env.token);

    try {
      console.log("Starting refreshing application (/) commands..");
      await rest.put(Routes.applicationGuildCommands(clientId, guildId), {
        body: client.CommandArray,
      });
      console.log("Successfully reloaded applicated (/) commands!");
    } catch (error) {
      console.error(error);
    }
  }
}