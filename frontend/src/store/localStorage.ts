import { TOKEN_KEY } from '@constants/session'

export const saveToken = (token: string): void =>
  localStorage.setItem(TOKEN_KEY, token)

export const getToken = (): string | null => localStorage.getItem(TOKEN_KEY)

export const removeToken = (): void => localStorage.removeItem(TOKEN_KEY)

export const saveToStorage = (key: string, value: string): void =>
  localStorage.setItem(key, value)
