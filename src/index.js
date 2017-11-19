'use strict'

require('ace-css/css/ace.css')
require('font-awesome/css/font-awesome.css')

import './main.css'
import { Main } from './Main.elm'
import registerServiceWorker from './registerServiceWorker'

Main.embed(document.getElementById('root'))

registerServiceWorker()
