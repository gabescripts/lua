require("dotenv").config();

const {SlashCommandBuilder, ApplicationCommandOptionType, EmbedBuilder, Embed} = require("discord.js");
const luawl = require("luawl");
luawl.token = process.env.luawl_token;

module.exports = {
  data: new SlashCommandBuilder()
    .setName("resethwid")
    .setDescription("Resets your key's hwid, fixes error codes 501/502."),
  async execute(interaction, client) {
    const Message = await interaction.deferReply({fetchReply: true});
    const UserId = interaction.user.id;
    const Whitelist = await luawl.GetUser(UserId);

    var StatusColor = 0x940000;
    var StatusMessage = "";
    var EmbedTitle = "HWID Status";

    if (Whitelist.key_status === "Active" && Whitelist.HWID) {
      const Result = await luawl.ResetHWID(UserId);

      if (Result.error) {
        EmbedTitle = "HWID API Error";
        StatusMessage = Result.error;
      } else {
        StatusMessage = "HWID has been reset, it will be set again when you execute the script. ";
        StatusColor = 0x009405;
      }

    } else if (Whitelist.key_status === "Assigned") {
      StatusMessage = "Key's HWID doesn't exist already!";
    } else if ((Whitelist.key_status === "Active") && !Whitelist.HWID) {
      StatusMessage = "Key's HWID was reset already!";
    } else {
      StatusMessage = "No key was found!"
    }

    const NewMessage = new EmbedBuilder()
    .setTitle(EmbedTitle)
    .setURL("https://gabescripts.com/getkey.php")
    .setThumbnail(interaction.user.avatarURL())
    .setDescription(StatusMessage)
    .setColor(StatusColor)
    .setTimestamp(Date.now())
    .setFooter({text: "V1.0 Testing"});

    await interaction.editReply({embeds: [NewMessage]});
  }
}