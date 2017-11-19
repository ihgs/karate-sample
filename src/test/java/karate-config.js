function() {
  var config = {
      urlBase: 'https://qiita.com/api/v2',
      qiita: {
        user_id: 'ihgs'
      }
  };
  karate.configure('connectTimeout', 5000);
  karate.configure('readTimeout', 5000);
  return config;
}
