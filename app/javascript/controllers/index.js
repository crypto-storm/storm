// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from "./application"

import NavbarController from "./navbar_controller"
application.register("navbar", NavbarController)

import PieChartController from "./pie_chart_controller"
application.register("pie-chart", PieChartController)

import LineChartController from "./line_chart_controller"
application.register("line-chart", LineChartController)
