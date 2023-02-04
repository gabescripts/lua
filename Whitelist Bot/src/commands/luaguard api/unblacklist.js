require("dotenv").config();
const {owner_id, luawl_token} = process.env;
const {SlashCommandBuilder, ApplicationCommandOptionType, EmbedBuilder, Embed, Status} = require("discord.js");

const luawl = require("luawl");
luawl.token = luawl_token;

module.exports = {
  data: new SlashCommandBuilder()
    .setName("unblacklist")
    .setDescription("Unblacklists the user from the script.")
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
    var StatusColor = 0x940000;
    var StatusMessage = "";

    if (interaction.user.id == owner_id) {
      if (Whitelist.key_status === "Blacklisted") {
        const Response = await luawl.UnBlacklist(UserId);
        StatusMessage = "Successfully UnBlacklisted";
        StatusColor = 0x009405;
      } else {
        StatusMessage = "No Blacklist Found";
      }
    } else {
      StatusMessage = "Unauthorized";
    }

    const NewMessage = new EmbedBuilder()
    .setTitle("Blacklist Status")
    .setColor(StatusColor)
    .setThumbnail(client.user.displayAvatarURL())
    .setTimestamp(Date.now())
    .setFooter({text: "V1.0 Testing"})
    .addFields([
      {
        name: "Discord ID",
        inline: true,
        value: `${UserId}`
      },
      {
        name: "Status",
        inline: true,
        value: `${StatusMessage}`
      }
    ]);

    await interaction.editReply({embeds: [NewMessage]});
  }
}