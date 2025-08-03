
// Representa a un empleado cuyo sueldo depende de su categoría, asistencia y rendimiento"
object pepe {
  var categoria = cadete
  var diasQueFalto = 0

  var bonoPorPresentismo = bonoPresentismoCompleto
  var bonoPorResultados = bonoResultadosFijo

  method categoria() = categoria
  method categoria(nueva) {
    categoria = nueva
  }

  method diasQueFalto() = diasQueFalto
  method diasQueFalto(cantidad) {
    diasQueFalto = cantidad
  }

  method bonoPorPresentismo() = bonoPorPresentismo
  method bonoPorPresentismo(nuevo) {
    bonoPorPresentismo = nuevo
  }

  method bonoPorResultados() = bonoPorResultados
  method bonoPorResultados(nuevo) {
    bonoPorResultados = nuevo
  }

  // Calcula el sueldo total de Pepe en base al neto, presentismo y resultados"
  method sueldo() = 
    self.categoria().sueldoNeto() +
    self.bonoPorPresentismo().calcularPara(self) +
    self.bonoPorResultados().calcularPara(self)
}

object gerente {
  method sueldoNeto() = 1000
}

object cadete {
  method sueldoNeto() = 1500
}

object bonoPresentismoCompleto {
  method calcularPara(empleado) = 
    if (empleado.diasQueFalto() == 0)  100
    else if (empleado.diasQueFalto() == 1)  50
    else 0
}

object bonoPresentismoNulo {
  method calcularPara(empleado) = 0
}

object bonoResultadosPorcentaje {
  method calcularPara(empleado) = empleado.categoria().sueldoNeto() * 0.1
}

object bonoResultadosFijo {
  method calcularPara(empleado) = 80
}

object bonoResultadosNulo {
  method calcularPara(empleado) = 0
}