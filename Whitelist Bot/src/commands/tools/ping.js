const {SlashCommandBuilder, ApplicationCommandOptionType, EmbedBuilder, Embed, inlineCode} = require("discord.js");

module.exports = {
  data: new SlashCommandBuilder()
    .setName("ping")
    .setDescription("Returns server and client ping."),
  async execute(interaction, client) {
    const message = await interaction.deferReply({fetchReply: true});
    const NewMessage = new EmbedBuilder()
      .setTitle("Ping Information")
      .setThumbnail(client.user.displayAvatarURL())
      .setTimestamp(Date.now())
      .setFooter({text: "V1.0 Testing"})
      .addFields([
        {
          name: "Server Ping",
          inline: true,
          value: `${client.ws.ping}ms`
        },
        {
          name: "Client Ping",
          inline: true,
          value: `${message.createdTimestamp - interaction.createdTimestamp}ms`
        }
      ]);

    await interaction.editReply({embeds: [NewMessage]});
  }
}