const dotenv = require('dotenv')

const dotenvFiles = [
  '/app/.env'
]
dotenvFiles.forEach((dotenvFile) => {
  dotenv.config({ path: dotenvFile, silent: true })
})

export const xapikeyenv = process.env.XAPIKEY
