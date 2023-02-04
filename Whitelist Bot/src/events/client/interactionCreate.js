module.exports = {
  name: "interactionCreate",
  async execute(interaction, client) {
    if (interaction.isChatInputCommand()) {
      const {Commands} = client;
      const {commandName} = interaction;
      const command = Commands.get(commandName);

      if (!command) return;
      try {
        await command.execute(interaction, client);
      } catch (error) {
        await interaction.reply({
          content: `Something went wrong while executing this command! ${error}`,
          ephemeral: true
        });
      }
    }
  }
}