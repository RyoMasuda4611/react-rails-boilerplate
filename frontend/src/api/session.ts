import client from '@api/index'
import { saveToken, removeToken } from '../store/localStorage'

interface SignInParams {
  email: string
  password: string
}

export const signIn = async (params: SignInParams): Promise<void> => {
  const res = await client.post('/api/v1/sign_in', { auth: params })
  const token = res.data?.jwt
  if (token) {
    saveToken(token)
  }
}

export const signOut = (): void => {
  removeToken()
}
