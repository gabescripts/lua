const FS = require("fs");

module.exports = (client) => {
  client.handleEvents = async() => {
    const eventFolders = FS.readdirSync(`./src/events`);
    
    for (const folder of eventFolders) {
      const eventFiles = FS
        .readdirSync(`./src/events/${folder}`)
        .filter((file) => file.endsWith(".js"));

      switch (folder) {
        case "client":
          for (const file of eventFiles) {
            const event = require(`../../events/${folder}/${file}`);
            if (event.once) 
              client.once(event.name, (...args) => 
                event.execute(...args, client)
              );
            else
              client.on(event.name, (...args) => 
                event.execute(...args, client)
              );
          }
          break;
      }
    }
  }
}