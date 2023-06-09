import { Controller } from "@hotwired/stimulus"
import React from 'react'
import ReactDOM from 'react-dom'
import App from '../components/App'

// Connects to data-controller="react"
export default class extends Controller {
  connect() {
    console.log("React Controller Connected")
    const app = document.getElementById('app')
    ReactDOM.render(<App />, app)
  }
}
