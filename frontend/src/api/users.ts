/* eslint-disable import/prefer-default-export */
import client from '@api/index'

export const createUser = async (): Promise<Record<string, unknown>> =>
  client.post('/users')
