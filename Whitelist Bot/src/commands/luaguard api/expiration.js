require("dotenv").config();

const {SlashCommandBuilder, ApplicationCommandOptionType, EmbedBuilder, Embed, inlineCode} = require("discord.js");
const luawl = require("luawl");
luawl.token = process.env.luawl_token;

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
    .setName("expiration")
    .setDescription("Gets your available key's expiration."),
  async execute(interaction, client) {
    const Message = await interaction.deferReply({fetchReply: true});
    const UserId = interaction.user.id;
    const Whitelist = await luawl.GetUser(UserId);
    const TimeNow = Math.floor(Date.now() / 1000);
    const ExpirationTime = new Date(Whitelist.expiration).getTime() / 1000;
    const TimeLeft = Whitelist.expiration ? Convert(ExpirationTime - TimeNow) : typeof Whitelist === "object" ? "Permanent Key" : "No Active Key";
    const StatusColor = Whitelist.expiration ? 0x009405 : typeof Whitelist === "object" ? 0x009405 : 0x940000;

    const NewMessage = new EmbedBuilder()
      .setTitle("Click For New Key")
      .setURL("https://gabescripts.com/getkey.php")
      .setThumbnail(interaction.user.avatarURL())
      .setColor(StatusColor)
      .setTimestamp(Date.now())
      .setFooter({text: "V1.0 Testing"})
      .addFields([
        {
          name: "Script User",
          inline: true,
          value: `${interaction.user.username}#${interaction.user.discriminator}`
        },
        {
          name: "Key Status",
          inline: true,
          value: Whitelist.key_status ? Whitelist.key_status : "None"
        },
        {
          name: "Expiration",
          inline: true,
          value: `${TimeLeft}`
        }
      ]);
      
    await interaction.editReply({embeds: [NewMessage]});
  }
}