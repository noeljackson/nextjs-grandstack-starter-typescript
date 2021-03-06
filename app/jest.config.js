module.exports = {
  roots: ["<rootDir>"],
  moduleFileExtensions: ["js", "ts", "tsx", "json"],
  setupFiles: ["<rootDir>/jest.setup.js", "dotenv/config"],
  testPathIgnorePatterns: [
    "<rootDir>[/\\\\](build|docs|node_modules|.next|.vercel|coverage)[/\\\\]",
  ],
  transformIgnorePatterns: ["[/\\\\]node_modules[/\\\\].+\\.(ts|tsx)$"],
  transform: {
    "\\.(gql|graphql)$": "@jagi/jest-transform-graphql",
    "^.+\\.(ts|tsx)$": "babel-jest",
  },
}
