import axios from 'axios'
import { getToken, saveToken } from '@store/localStorage'

export const apiUrl =
  process.env.REACT_APP_SERVER_URL ||
  (process.env.NODE_ENV === 'development' ? 'http://localhost:3000' : '/')

const client = axios.create({
  baseURL: apiUrl,
  timeout: 7000,
  headers: {
    'Content-Type': 'application/json',
  },
})

client.interceptors.request.use(
  (config) => {
    const token = getToken()
    if (token) {
      config.headers.Authorization = `Bearer ${token}`
    }
    return config
  },
  (error) => Promise.reject(error)
)

client.interceptors.response.use(
  (response) => {
    const token = response.headers && response.headers.authorization
    if (token) {
      saveToken(token)
    }
    return response
  },
  (error) => Promise.reject(error)
)

client.interceptors.response.use(
  (response) => {
    const token = response.headers && response.headers.authorization

    if (token) {
      saveToken(token)
    }
    return response
  },
  (error) => {
    if (error.response) {
      console.log('response')
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx
      console.log(error.response.data)
      console.log(error.response.status)
      console.log(error.response.headers)

      if (error.response.status === 400) {
        // サーバー側のエラー
        console.error(error)
      } else if (error.response.status === 401) {
        // 認証エラー時の処理
        console.error(error)
      } else if (error.response.status === 500) {
        // システムエラー時の処理
        console.error(error)
      }
    } else if (error.request) {
      console.log('request')
      // The request was made but no response was received
      // `error.request` is an instance of XMLHttpRequest in the browser and an instance of
      // http.ClientRequest in node.js
      console.log(error.request)
    } else {
      console.log('other')
      // Something happened in setting up the request that triggered an Error
      console.log('Error', error.message)
    }
    return Promise.reject(error)
  }
)

export default client
