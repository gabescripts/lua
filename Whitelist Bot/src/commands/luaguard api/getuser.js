require("dotenv").config();

const {SlashCommandBuilder, ApplicationCommandOptionType, EmbedBuilder, Embed} = require("discord.js");
const luawl = require("luawl");
const {owner_id, luawl_token} = process.env;
luawl.token = luawl_token;

function Convert(Elapsed) {
  const Days = Math.floor((Elapsed / 86400))
  const Hours = Math.floor((Elapsed / 3600) % 24)
  const Minutes = Math.floor((Elapsed / 60) % 60)
  const Seconds = Math.floor(Elapsed % 60)

  if (Days === 1) {return `${Days} Day, ${Hours} Hours, ${Minutes} Minutes`;} else if (Days > 1) {return `${Days} Days, ${Hours} Hours, ${Minutes} Minutes`;}
  if (Hours === 1) {return `${Hours} Hour, ${Minutes} Minutes`;} else if (Hours > 1) {return `${Hours} Hours, ${Minutes} Minutes`;}
  if (Minutes === 1) {return `${Minutes} Minute, ${Seconds} Seconds`;} else if (Minutes > 1) {return `${Minutes} Minutes, ${Seconds} Seconds`;}
  if (Seconds === 1) {return `${Seconds} Seconds`;} else if (Seconds > 1) {return `${Seconds} Seconds`;}

  return "Expired";
}

module.exports = {
  data: new SlashCommandBuilder()
    .setName("getuser")
    .setDescription("Gets user's whitelist information.")
    .addStringOption((option) => option
      .setName("userid")
      .setDescription("Enter userid to be searched.")
      .setRequired(true)
    ),
  async execute(interaction, client) {
    const Message = await interaction.deferReply({fetchReply: true});
    const UserId = interaction.options.getString("userid");
    const Whitelist = await luawl.GetUser(UserId);
    const TimeNow = Math.floor(Date.now() / 1000);
    const ExpirationTime = new Date(Whitelist.expiration).getTime() / 1000;
    const TimeLeft = Whitelist.expiration ? Convert(ExpirationTime - TimeNow) : typeof Whitelist === "object" ? "Permanent Key" : "No Active Key";

    // Command Is Only For Owner
    var NewMessage;
    if (interaction.user.id == owner_id) {
      var NewMessage = new EmbedBuilder()
      .setTitle("Whitelist Information")
      .setDescription(`\`\`\`Discord ID: ${Whitelist.discord_id ? Whitelist.discord_id : UserId}\nKey: ${Whitelist.wl_key ? Whitelist.wl_key : "No Key"}\nStatus: ${Whitelist.key_status ? Whitelist.key_status : "None"}, ${TimeLeft}\nHWID: ${Whitelist.HWID ? Whitelist.HWID : "Missing"}\`\`\``)
      .setTimestamp(Date.now())
      .setFooter({text: "V1.0 Testing"});
    } else {
      var NewMessage = new EmbedBuilder()
      .setTitle("Command Failed")
      .setColor(0x940000)
      .setDescription(`\`\`\`Caller: ${interaction.user.username}#${interaction.user.discriminator}\nError: Missing Required Permissions.\`\`\``)
      .setTimestamp(Date.now())
      .setFooter({text: "V1.0 Testing"});
    }

    await interaction.editReply({embeds: [NewMessage]});
  }
}