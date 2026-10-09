# frozen_string_literal: true

# Clase para describir a lso jugadores
class Jugador
  attr_reader :nombre, :puntos

  def initialize(nombre)
    @nombre = nombre
    @puntos = 0
  end

  def sumar_puntos(puntos)
    @puntos += puntos
  end
end

# Modulo para descrbiir como se comporta los marcadores
module Marcador
  REGLAS = {
    juego: {
      normal: 4,
      muerteA7: 7,
      muerteA10: 10
    },
    set: {
      normal: 6,
      A4: 4
    }
  }.freeze

  def self.valido?(categoria, puntos_a, puntos_b, variante: :normal, con_ventajas: true)
    return false unless [a, b].all?(Integer)

    minimo = REGLAS.dig(categoria, variante)
    return false if minimo.nil? # categoría o variante inexistente

    ganador = [puntos_a, puntos_b].max
    perdedor = [puntos_a, puntos_b].min
    return false if perdedor.negative?

    case categoria
    when :set then set_valido?(ganador, perdedor, minimo)
    when :juego then juego_valido?(ganador, perdedor, minimo, con_ventajas)
    end
  end

  def self.set_valido?(ganador, perdedor, minimo)
    return perdedor <= minimo - 2 if ganador == minimo

    ganador == minimo + 1 && perdedor >= minimo - 1
  end

  def self.juego_valido?(ganador, perdedor, minimo, con_ventajas)
    return false if ganador < minimo

    if con_ventajas
      ganador == minimo ? perdedor <= minimo - 2 : ganador - perdedor == 2
    else
      ganador == minimo && perdedor < minimo
    end
  end
end

class Partido
  # private_class_method :new
  attr_reader :jugador1, :jugador2, :ganador, :puntos_en_juego, :tipo_de_partido, :marcadores, :con_ventajas

  TIPOS_DE_PARTIDOS = %i[muerte_a_10 muerte_a_7 normal].freeze
  VALORES = {
    normal: 4,
    muerte_a_7: 7,
    muerte_a_10: 10
  }.freeze

  NOMBRES_DE_TIPOS = {
    muerteA10: 'muerte súbita a 10',
    muerteA7: 'muerte súbita a 7',
    normal: 'a 4 games'
  }.freeze

  def initialize(jugador1, jugador2, puntos_en_juego, tipo_de_partido, _con_ventajas)
    [jugador1, jugador1].each do |j|
      raise ArgumentError, "se esperaba un Jugador, llego #{j.class}" unless j.is_a?(Jugador)
    end
    unless TIPOS_DE_PARTIDOS.include?(tipo_de_partido)
      raise ArgumentError,
            "tipo de partido inválido: #{tipo_de_partido}"
    end

    @jugador1 = jugador1
    @jugador2 = jugador2
    @puntos_en_juego = puntos_en_juego
    @tipo_de_partido = tipo_de_partido
    @ganador = nil
    @marcadores = []
  end

  def registrar_marcador(a, b)
    @marcadores << Marcador.new(a, b, VALORES.fetch(@tipo_de_partido), @con_ventajas)
    @marcadores.first.gana_jugador_1? ? registrar_ganador(@jugador1) : registrar_ganador(@jugador2)
  end

  def to_s
    "#{jugador1.nombre} vs #{jugador2.nombre}"
  end

  private

  def registrar_ganador(jugador)
    @ganador = jugador
    jugador == @jugador1 ? @jugador2 : @jugador1

    jugador.sumar_puntos(@puntos_en_juego)

    "Terminó #{@jugador1.nombre} vs #{@jugador2.nombre} jugaron #{NOMBRES_DE_TIPOS[@tipo_de_partido]}. " \
    "Ganador: #{jugador.nombre} (+#{@puntos_en_juego}), ahora tiene #{jugador.puntos}. "
  end
end

class Torneo
  attr_reader :nombre, :jugadores, :partidos, :puntos_prueba

  def initialize(nombre, puntos_prueba)
    @puntos_prueba = puntos_prueba
    @nombre = nombre
    @jugadores = []
    @partidos = []
  end

  def agregar_jugador(jugador)
    @jugadores << jugador
  end

  def armar_partidos(tipo_de_partido, con_ventajas)
    @partidos = []
    @jugadores.shuffle.each_slice(2) do |j1, j2|
      @partidos << Partido.new(j1, j2,  @puntos_prueba, tipo_de_partido, con_ventajas)
    end
  end
end
