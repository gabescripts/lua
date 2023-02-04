# <b>[luawl](https://luawl.com)</b>, also known as <b>luaGuard</b>

<center><a href="https://discord.gg/w7ubyMZyyw"><img src="https://img.shields.io/discord/917573858461102080?color=5865F2&logo=discord&logoColor=white" alt="Discord Server"/></a></center>

## Example (JavaScript)
```js
/**
 * you do not have to share luawl variable with another files, unless you want to
 */

// ex. 1
require('luawl').token = 'API_TOKEN'

// ex. 2
const luawl = require('luawl')

luawl.token = 'API_TOKEN'

luawl.getWhitelist({ discord_id: "id" }).then(response => {
	console.log(response)
})
```

## Example (TypeScript)
```ts
/**
 * you do not have to share luawl variable with another files, unless you want to
 */
import * as luawl from 'luawl'

luawl.token = 'API_TOKEN'

luawl.getWhitelist({ discord_id: "id" }).then(response => {
	console.log(response)
})
```