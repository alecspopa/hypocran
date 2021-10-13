# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

first_package = Package.create(
  name: "ABC",
  title: "Tools for Approximate Bayesian Computation (ABC)",
  description: "The package implements several ABC algorithms for performing parameter estimation and model selection"
)

second_package = Package.create(
  name: "Benchmarking",
  title: "Benchmark and Frontier Analysis Using DEA and SFA",
  description: <<~DESC
    Methods for frontier
    analysis, Data Envelopment Analysis (DEA), under different
    technology assumptions (fdh, vrs, drs, crs, irs, add/frh, and fdh+),
    and using different efficiency measures (input based, output based,
    hyperbolic graph, additive, super, and directional efficiency). Peers
    and slacks are available, partial price information can be included,
    and optimal cost, revenue and profit can be calculated. Evaluation of
    mergers is also supported.  Methods for graphing the technology sets
    are also included. There is also support for comparative methods based
    on Stochastic Frontier Analyses (SFA) and for convex nonparametric
    least squares for convex functions (StoNED). In general, the methods
    can be used to solve not only standard models, but also many other
    model variants. It complements the book, Bogetoft and Otto,
    Benchmarking with DEA, SFA, and R, Springer-Verlag, 2011, but can of
    course also be used as a stand-alone package.
  DESC
)

PackageVersion.create([
  {
    package_id: first_package.id,
    name: "1.6"
  },
  {
    package_id: first_package.id,
    name: "1.5"
  },
  {
    package_id: first_package.id,
    name: "1.4"
  },
  {
    package_id: first_package.id,
    name: "1.3"
  },
  {
    package_id: first_package.id,
    name: "1.2"
  },
  {
    package_id: second_package.id,
    name: "0.29"
  },
  {
    package_id: second_package.id,
    name: "0.28"
  },
  {
    package_id: second_package.id,
    name: "0.27"
  },
  {
    package_id: second_package.id,
    name: "0.26"
  },
  {
    package_id: second_package.id,
    name: "0.25"
  }
])
