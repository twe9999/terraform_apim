const axios = require('axios');
const fs = require('fs');
const fs2 = require('fs').promises;

/**
 * 取得遠端資料
 * @param { string} funcPath
 * @param {*} reqHeader
 * @param {*} reqBody
 * @returns
 */
const fetchData = async (funcPath, reqHeader, reqBody) => {
  const { data } = await axios.get('https://ifconfig.me');
  rsData = 'IP: ' + data + 'test';

  return {
    body: rsData,
    headers: {
      'Content-Type': 'application/json',
    },
  };
};

/**
 * 提供出去的API介面
 * @param {*} context
 * @param {*} req
 * @returns
 */
module.exports = async (context, req) => {
  context.log('JavaScript trigger function processed a request.');
  return await fetchData(context.bindingData.funcpath, req.headers, req.body);
};
