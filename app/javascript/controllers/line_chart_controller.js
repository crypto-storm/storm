import { Controller } from "@hotwired/stimulus"
import Chart from 'chart.js/auto'

const CHART_COLORS = {
  red: 'rgb(255, 99, 132)',
  orange: 'rgb(255, 159, 64)',
  yellow: 'rgb(255, 205, 86)',
  green: 'rgb(75, 192, 192)',
  blue: 'rgb(54, 162, 235)',
  purple: 'rgb(153, 102, 255)',
  grey: 'rgb(201, 203, 207)'
};

export default class extends Controller {
  static targets = ["line"]
  static values = {
    distribution: Object
  }

  connect() {
    this.lineChart()
  }

  lineChart() {
    const data = {
      labels: Object.keys(this.distributionValue),
      datasets: [
        {
          label: 'Distribution',
          data: Object.values(this.distributionValue),
          backgroundColor: Object.values(CHART_COLORS),
        }
      ]
    };

    const config = {
      type: 'line',
      data: data,
      options: {
        interaction: {
          axis: 'x',
          mode: 'nearest',
          intersect: false
        },
        responsive: true,
        plugins: {
          legend: {
            position: 'top',
          },
          title: {
            display: true,
            text: 'Portfolio Total Value By Date'
          }
        }
      },
    };

    const chart = new Chart(this.lineTarget, config)
  }
}
