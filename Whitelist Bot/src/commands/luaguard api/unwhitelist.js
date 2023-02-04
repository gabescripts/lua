require("dotenv").config();
const {owner_id, luawl_token} = process.env;
const {SlashCommandBuilder, ApplicationCommandOptionType, EmbedBuilder, Embed, Status} = require("discord.js");

const luawl = require("luawl");
luawl.token = luawl_token;

module.exports = {
  data: new SlashCommandBuilder()
    .setName("unwhitelist")
    .setDescription("Removes user's whitelist key.")
    .addStringOption((option) => option
      .setName("userid")
      .setDescription("Enter userid to be searched.")
      .setRequired(true)
    ),
  async execute(interaction, client) {
    const Message = await interaction.deferReply({fetchReply: true});
    const UserId = interaction.options.getString("userid");
    const Whitelist = await luawl.GetUser(UserId);

    // Command Is Only For Owner
    var StatusMessage;
    var StatusColor = 0x940000;

    if (interaction.user.id == owner_id) {
      if (Whitelist === "Key Data Not Found.") {
        StatusMessage = "No whitelist information.";
      } else {
        const Result = await luawl.UnWhitelist(UserId);
        StatusMessage = "Successfully removed user's whitelist.";
        StatusColor = 0x009405;
      }
    } else {
      StatusMessage = "Missing required permissions.";
    }
    const NewMessage = new EmbedBuilder()
    .setTitle("Whitelist Status")
    .setColor(StatusColor)
    .setThumbnail(client.user.displayAvatarURL())
    .setTimestamp(Date.now())
    .setFooter({text: "V1.0 Testing"})
    .addFields([
      {
        name: "Discord ID",
        inline: true,
        value: UserId
      },
      {
        name: "Status",
        inline: true,
        value: StatusMessage
      }
    ]);

    await interaction.editReply({embeds: [NewMessage]});
  }
}