require("dotenv").config();

const {SlashCommandBuilder, ApplicationCommandOptionType, EmbedBuilder, Embed, GuildMemberRoleManager} = require("discord.js");
const luawl = require("luawl");
luawl.token = process.env.luawl_token;

module.exports = {
  data: new SlashCommandBuilder()
    .setName("getrole")
    .setDescription("Gives you the whitelisted role if owned key."),
  async execute(interaction, client) {
    const Message = await interaction.deferReply({fetchReply: true});
    const UserId = interaction.user.id;

    const Whitelist = await luawl.GetUser(UserId);
    const Role = await luawl.BuyerRole();
    const HasRole = interaction.member.roles.cache.has(Role);
    
    var StatusColor = 0x940000;
    var StatusMessage = "";

    // Checks If Whitelisted And Has No Role
    if ((Whitelist.key_status === "Active" || Whitelist.key_status === "Assigned") && !HasRole) {
        await interaction.member.roles.add(Role);
        StatusMessage = "Claimed whitelisted role!";
        StatusColor = 0x009405;
    } else if (HasRole) {
      StatusMessage = "You have already claimed the whitelisted role!";
    } else {
      StatusMessage = "You are not whitelisted, you need an active key!"
    }

    const NewMessage = new EmbedBuilder()
      .setTitle("Whitelisted Role")
      .setDescription(StatusMessage)
      .setColor(StatusColor)
      .setThumbnail(interaction.user.avatarURL())
      .setTimestamp(Date.now())
      .setFooter({text: "V1.0 Testing"});

    await interaction.editReply({embeds: [NewMessage]});
  }
}