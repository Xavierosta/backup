# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Movement.create(tmin: 0.0, tmax: 10.0, destination: '/VoiceRecorderTest')
Movement.create(tmin: 10.0, tmax: 20.0, destination: '/JobMarketTest/AudioTest/Typist-LP')
Movement.create(tmin: 20.0, tmax: 30.0, destination: '/JobMarketTest/AudioTest/Typist-HP')
Movement.create(tmin: 30.0, tmax: 35.0, destination: '/JobMarketTest/AudioTest/Email')
Movement.create(tmin: 35.0, tmax: 40.0, destination: '/JobMarketTest/AudioTest/Admin')
Movement.create(tmin: 40.0, tmax: 50.0, destination: '/JobMarketTest/AudioTest/Typist-LP')
Movement.create(tmin: 50.0, tmax: 60.0, destination: '/JobMarketTest/AudioTest/Typist-HP')
