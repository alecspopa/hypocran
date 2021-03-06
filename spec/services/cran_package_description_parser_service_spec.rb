require 'rails_helper'

RSpec.describe CranPackageDescriptionParserService, type: :service do
  it "parses the sample content" do
    expect(described_class.parse(content)).to eq(expected_package)
  end

  def content
    return (<<~PACKAGE_DESCRIPTION)
      Package: Benchmarking
      Type: Package
      Title: Benchmark and Frontier Analysis Using DEA and SFA
      Version: 0.29
      Date: 2020-8-8
      Author: Peter Bogetoft and Lars Otto
      Maintainer: Lars Otto <larsot23@gmail.com>
      Depends: lpSolveAPI, ucminf, quadprog
      Imports: methods, stats, graphics, grDevices, Rcpp
      LinkingTo: Rcpp
      Description: Methods for frontier
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
      License: GPL (>= 2)
      LazyLoad: yes
      NeedsCompilation: yes
      Packaged: 2020-08-07 08:49:15 UTC; lao
      Repository: CRAN
      Date/Publication: 2020-08-07 09:52:06 UTC
    PACKAGE_DESCRIPTION
  end

  def expected_package
    described_class::Package.new(
      "Benchmarking",
      "Benchmark and Frontier Analysis Using DEA and SFA",
      "0.29",
      expected_package_description.squish
    )
  end

  def expected_package_description
    return (<<~DESCRIPTION)
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
    DESCRIPTION
  end
end
