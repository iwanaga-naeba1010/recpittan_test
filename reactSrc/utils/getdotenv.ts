const dotenvFiles = [
  '/app/.env'
]

import dotenv from '/app/node_modules/dotenv';

dotenvFiles.forEach((dotenvFile) => {
  dotenv.config({ path: dotenvFile, silent: true })
})

export const xapikeyenv = process.env.XAPIKEY
