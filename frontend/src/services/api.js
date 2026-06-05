// api.js — Tutte le chiamate HTTP centralizzate in un posto

import axios from 'axios'

const BASE_URL = 'http://localhost:8000'

export async function fetchHistogramData(bins) {
  const response = await axios.get(`${BASE_URL}/histogram`, {
    params: { bins }
  })
  return response.data
}