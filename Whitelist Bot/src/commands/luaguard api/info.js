require("dotenv").config();

const {SlashCommandBuilder, ApplicationCommandOptionType, EmbedBuilder, Embed, inlineCode} = require("discord.js");
const luawl = require("luawl");
luawl.token = process.env.luawl_token;

module.exports = {
  data: new SlashCommandBuilder()
    .setName("info")
    .setDescription("Gets bot information."),
  async execute(interaction, client) {
    const Message = await interaction.deferReply({fetchReply: true});
    const {total_executions, active_keys, current_executions} = await luawl.Request("getAccountStats");
    const NewMessage = new EmbedBuilder()
      .setTitle("Bot Information")
      .setThumbnail(client.user.displayAvatarURL())
      .setDescription("In Gabe We Trust")
      .setColor(0x009405)
      .setTimestamp(Date.now())
      .setFooter({text: "V1.0 Testing"})
      .addFields([
        {
          name: "Script Developer",
          inline: true,
          value: "gabe#0002"
        },
        {
          name: "Bot Developer",
          inline: true,
          value: "gabe#0002" 
        },
        {
          name: "Whitelist Developer",
          inline: true,
          value: "wYn#4428" 
        },
        {
          name: "Active Keys",
          inline: true,
          value: active_keys
        },
        {
          name: "Online Users",
          inline: true,
          value: current_executions
        },
        {
          name: "Total Executions",
          inline: true,
          value: total_executions
        }
      ]);

    await interaction.editReply({embeds: [NewMessage]});
  }
}