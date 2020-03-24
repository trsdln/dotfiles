const extractPositionFromMessage = (filePath, message) => {
  const positionToken = message.split(filePath)[1].split(')')[0];
  return positionToken;
};

const createTestCaseResultLine = filePath => testCaseResult => `.${filePath.replace(process.cwd(), '')}${extractPositionFromMessage(
  filePath,
  testCaseResult.failureMessages[0],
)} ${testCaseResult.fullName}`;

const unnest = xs => xs.reduce((acc, x) => acc.concat(x), []);

function extractUnixFriendlyTestResults(testResults) {
  const resultsLines = testResults.map(testFileResult => testFileResult.testResults
    .filter(result => result.status === 'failed')
    .map(createTestCaseResultLine(testFileResult.testFilePath)),
  );
  const flatResultsLines = unnest(resultsLines);
  return flatResultsLines.join('\n');
}

class JestUnixReporter {
  constructor(globalConfig, options) {
    this._globalConfig = globalConfig;
    this._options = options;
  }

  onRunComplete(contexts, results) {
    const unixFriendlyResultsStr = extractUnixFriendlyTestResults(
      results.testResults,
    );
    console.log(unixFriendlyResultsStr);
  }
}

module.exports = JestUnixReporter;
