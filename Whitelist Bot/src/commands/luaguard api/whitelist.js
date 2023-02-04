require("dotenv").config();
const {owner_id, luawl_token} = process.env;
const {SlashCommandBuilder, ApplicationCommandOptionType, EmbedBuilder, Embed, Status} = require("discord.js");

const luawl = require("luawl");
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
    .setName("whitelist")
    .setDescription("Gives user a whitelisted key with a set duration.")
    .addStringOption((option) => option
      .setName("userid")
      .setDescription("Enter userid to be searched.")
      .setRequired(true)
    )
    .addStringOption((option) => option
    .setName("hours")
    .setDescription("Enter hours the key will last.")
    .setRequired(true)
  ),
  async execute(interaction, client) {
    const Message = await interaction.deferReply({fetchReply: true});
    const UserId = interaction.options.getString("userid");
    const TrialHours = interaction.options.getString("hours");
    const Whitelist = await luawl.GetUser(UserId);

    // Command Is Only For Owner
    var StatusColor = 0x940000;
    var StatusMessage = "";
    var StatusKey = "None";

    if (interaction.user.id == owner_id) {
      if (Whitelist === "Key Data Not Found.") {
        var StatusKey = await luawl.Whitelist(UserId, TrialHours);
        StatusMessage = "Whitelisted";
        StatusColor = 0x009405;
      } else {
        StatusMessage = `${Whitelist.key_status}, already whitelisted`;
        StatusKey = Whitelist.wl_key;
      }
    } else {
      StatusMessage = "Unauthorized";
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
        value: `${UserId}`
      },
      {
        name: "Status",
        inline: true,
        value: `${StatusMessage}`
      },
      {
        name: "Expiration",
        inline: true,
        value: Convert(TrialHours * 3600)
      },
      {
        name: "Key",
        inline: true,
        value: StatusKey
      }
    ]);

    await interaction.editReply({embeds: [NewMessage]});
  }
}