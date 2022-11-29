# University Project

# compile contracts
npx hardhat compile --verbose

# deploy contract
npx hardhat run scripts/deploy.js --network polygon

# verify contract
npx hardhat verify 0x4EA50d7F815ccd4d2D865092d27dcfffE93962c5  --network polygon --constructor-args arguments/arg.js
