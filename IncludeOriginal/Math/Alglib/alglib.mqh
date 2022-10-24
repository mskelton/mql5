#ifndef ALGLIB_H
#define ALGLIB_H

#include "alglibmisc.mqh"
#include "dataanalysis.mqh"
#include "delegatefunctions.mqh"
#include "diffequations.mqh"
#include "fasttransforms.mqh"
#include "integration.mqh"
#include "interpolation.mqh"
#include <Object.mqh>

class CAlglib {
public:
  CAlglib(void);
  ~CAlglib(void);

  static void HQRndRandomize(CHighQualityRandStateShell &state);
  static void HQRndSeed(const int s1, const int s2,
                        CHighQualityRandStateShell &state);
  static double HQRndUniformR(CHighQualityRandStateShell &state);
  static int HQRndUniformI(CHighQualityRandStateShell &state, const int n);
  static double HQRndNormal(CHighQualityRandStateShell &state);
  static void HQRndUnit2(CHighQualityRandStateShell &state, double &x,
                         double &y);
  static void HQRndNormal2(CHighQualityRandStateShell &state, double &x1,
                           double &x2);
  static double HQRndExponential(CHighQualityRandStateShell &state,
                                 const double lambdav);

  static void KDTreeSerialize(CKDTreeShell &obj, string &s_out);
  static void KDTreeUnserialize(string s_in, CKDTreeShell &obj);
  static void KDTreeBuild(CMatrixDouble &xy, const int n, const int nx,
                          const int ny, const int normtype, CKDTreeShell &kdt);
  static void KDTreeBuild(CMatrixDouble &xy, const int nx, const int ny,
                          const int normtype, CKDTreeShell &kdt);
  static void KDTreeBuildTagged(CMatrixDouble &xy, int &tags[], const int n,
                                const int nx, const int ny, const int normtype,
                                CKDTreeShell &kdt);
  static void KDTreeBuildTagged(CMatrixDouble &xy, int &tags[], const int nx,
                                const int ny, const int normtype,
                                CKDTreeShell &kdt);
  static int KDTreeQueryKNN(CKDTreeShell &kdt, double &x[], const int k,
                            const bool selfmatch);
  static int KDTreeQueryKNN(CKDTreeShell &kdt, double &x[], const int k);
  static int KDTreeQueryRNN(CKDTreeShell &kdt, double &x[], const double r,
                            const bool selfmatch);
  static int KDTreeQueryRNN(CKDTreeShell &kdt, double &x[], const double r);
  static int KDTreeQueryAKNN(CKDTreeShell &kdt, double &x[], const int k,
                             const bool selfmatch, const double eps);
  static int KDTreeQueryAKNN(CKDTreeShell &kdt, double &x[], const int k,
                             const double eps);
  static void KDTreeQueryResultsX(CKDTreeShell &kdt, CMatrixDouble &x);
  static void KDTreeQueryResultsXY(CKDTreeShell &kdt, CMatrixDouble &xy);
  static void KDTreeQueryResultsTags(CKDTreeShell &kdt, int &tags[]);
  static void KDTreeQueryResultsDistances(CKDTreeShell &kdt, double &r[]);
  static void KDTreeQueryResultsXI(CKDTreeShell &kdt, CMatrixDouble &x);
  static void KDTreeQueryResultsXYI(CKDTreeShell &kdt, CMatrixDouble &xy);
  static void KDTreeQueryResultsTagsI(CKDTreeShell &kdt, int &tags[]);
  static void KDTreeQueryResultsDistancesI(CKDTreeShell &kdt, double &r[]);

  static void DSOptimalSplit2(double &a[], int &c[], const int n, int &info,
                              double &threshold, double &pal, double &pbl,
                              double &par, double &pbr, double &cve);
  static void DSOptimalSplit2Fast(double &a[], int &c[], int &tiesbuf[],
                                  int &cntbuf[], double &bufr[], int &bufi[],
                                  const int n, const int nc, const double alpha,
                                  int &info, double &threshold, double &rms,
                                  double &cvrms);

  static void DFSerialize(CDecisionForestShell &obj, string &s_out);
  static void DFUnserialize(const string s_in, CDecisionForestShell &obj);
  static void DFBuildRandomDecisionForest(CMatrixDouble &xy, const int npoints,
                                          const int nvars, const int nclasses,
                                          const int ntrees, const double r,
                                          int &info, CDecisionForestShell &df,
                                          CDFReportShell &rep);
  static void DFBuildRandomDecisionForestX1(
      CMatrixDouble &xy, const int npoints, const int nvars, const int nclasses,
      const int ntrees, int nrndvars, const double r, int &info,
      CDecisionForestShell &df, CDFReportShell &rep);
  static void DFProcess(CDecisionForestShell &df, double &x[], double &y[]);
  static void DFProcessI(CDecisionForestShell &df, double &x[], double &y[]);
  static double DFRelClsError(CDecisionForestShell &df, CMatrixDouble &xy,
                              const int npoints);
  static double DFAvgCE(CDecisionForestShell &df, CMatrixDouble &xy,
                        const int npoints);
  static double DFRMSError(CDecisionForestShell &df, CMatrixDouble &xy,
                           const int npoints);
  static double DFAvgError(CDecisionForestShell &df, CMatrixDouble &xy,
                           const int npoints);
  static double DFAvgRelError(CDecisionForestShell &df, CMatrixDouble &xy,
                              const int npoints);

  static void KMeansGenerate(CMatrixDouble &xy, const int npoints,
                             const int nvars, const int k, const int restarts,
                             int &info, CMatrixDouble &c, int &xyc[]);

  static void FisherLDA(CMatrixDouble &xy, const int npoints, const int nvars,
                        const int nclasses, int &info, double &w[]);
  static void FisherLDAN(CMatrixDouble &xy, const int npoints, const int nvars,
                         const int nclasses, int &info, CMatrixDouble &w);

  static void LRBuild(CMatrixDouble &xy, const int npoints, const int nvars,
                      int &info, CLinearModelShell &lm, CLRReportShell &ar);
  static void LRBuildS(CMatrixDouble &xy, double &s[], const int npoints,
                       const int nvars, int &info, CLinearModelShell &lm,
                       CLRReportShell &ar);
  static void LRBuildZS(CMatrixDouble &xy, double &s[], const int npoints,
                        const int nvars, int &info, CLinearModelShell &lm,
                        CLRReportShell &ar);
  static void LRBuildZ(CMatrixDouble &xy, const int npoints, const int nvars,
                       int &info, CLinearModelShell &lm, CLRReportShell &ar);
  static void LRUnpack(CLinearModelShell &lm, double &v[], int &nvars);
  static void LRPack(double &v[], const int nvars, CLinearModelShell &lm);
  static double LRProcess(CLinearModelShell &lm, double &x[]);
  static double LRRMSError(CLinearModelShell &lm, CMatrixDouble &xy,
                           const int npoints);
  static double LRAvgError(CLinearModelShell &lm, CMatrixDouble &xy,
                           const int npoints);
  static double LRAvgRelError(CLinearModelShell &lm, CMatrixDouble &xy,
                              const int npoints);

  static void MLPSerialize(CMultilayerPerceptronShell &obj, string &s_out);
  static void MLPUnserialize(const string s_in,
                             CMultilayerPerceptronShell &obj);
  static void MLPCreate0(const int nin, const int nout,
                         CMultilayerPerceptronShell &network);
  static void MLPCreate1(const int nin, int nhid, const int nout,
                         CMultilayerPerceptronShell &network);
  static void MLPCreate2(const int nin, const int nhid1, const int nhid2,
                         const int nout, CMultilayerPerceptronShell &network);
  static void MLPCreateB0(const int nin, const int nout, const double b,
                          const double d, CMultilayerPerceptronShell &network);
  static void MLPCreateB1(const int nin, int nhid, const int nout,
                          const double b, const double d,
                          CMultilayerPerceptronShell &network);
  static void MLPCreateB2(const int nin, const int nhid1, const int nhid2,
                          const int nout, const double b, const double d,
                          CMultilayerPerceptronShell &network);
  static void MLPCreateR0(const int nin, const int nout, double a,
                          const double b, CMultilayerPerceptronShell &network);
  static void MLPCreateR1(const int nin, int nhid, const int nout,
                          const double a, const double b,
                          CMultilayerPerceptronShell &network);
  static void MLPCreateR2(const int nin, const int nhid1, const int nhid2,
                          const int nout, const double a, const double b,
                          CMultilayerPerceptronShell &network);
  static void MLPCreateC0(const int nin, const int nout,
                          CMultilayerPerceptronShell &network);
  static void MLPCreateC1(const int nin, int nhid, const int nout,
                          CMultilayerPerceptronShell &network);
  static void MLPCreateC2(const int nin, const int nhid1, const int nhid2,
                          const int nout, CMultilayerPerceptronShell &network);
  static void MLPRandomize(CMultilayerPerceptronShell &network);
  static void MLPRandomizeFull(CMultilayerPerceptronShell &network);
  static void MLPProperties(CMultilayerPerceptronShell &network, int &nin,
                            int &nout, int &wcount);
  static bool MLPIsSoftMax(CMultilayerPerceptronShell &network);
  static int MLPGetLayersCount(CMultilayerPerceptronShell &network);
  static int MLPGetLayerSize(CMultilayerPerceptronShell &network, const int k);
  static void MLPGetInputScaling(CMultilayerPerceptronShell &network,
                                 const int i, double &mean, double &sigma);
  static void MLPGetOutputScaling(CMultilayerPerceptronShell &network,
                                  const int i, double &mean, double &sigma);
  static void MLPGetNeuronInfo(CMultilayerPerceptronShell &network, const int k,
                               const int i, int &fkind, double &threshold);
  static double MLPGetWeight(CMultilayerPerceptronShell &network, const int k0,
                             const int i0, const int k1, const int i1);
  static void MLPSetInputScaling(CMultilayerPerceptronShell &network,
                                 const int i, const double mean,
                                 const double sigma);
  static void MLPSetOutputScaling(CMultilayerPerceptronShell &network,
                                  const int i, const double mean,
                                  const double sigma);
  static void MLPSetNeuronInfo(CMultilayerPerceptronShell &network, const int k,
                               const int i, int fkind, double threshold);
  static void MLPSetWeight(CMultilayerPerceptronShell &network, const int k0,
                           const int i0, const int k1, const int i1,
                           const double w);
  static void MLPActivationFunction(const double net, const int k, double &f,
                                    double &df, double &d2f);
  static void MLPProcess(CMultilayerPerceptronShell &network, double &x[],
                         double &y[]);
  static void MLPProcessI(CMultilayerPerceptronShell &network, double &x[],
                          double &y[]);
  static double MLPError(CMultilayerPerceptronShell &network, CMatrixDouble &xy,
                         const int ssize);
  static double MLPErrorN(CMultilayerPerceptronShell &network,
                          CMatrixDouble &xy, const int ssize);
  static int MLPClsError(CMultilayerPerceptronShell &network, CMatrixDouble &xy,
                         const int ssize);
  static double MLPRelClsError(CMultilayerPerceptronShell &network,
                               CMatrixDouble &xy, const int npoints);
  static double MLPAvgCE(CMultilayerPerceptronShell &network, CMatrixDouble &xy,
                         const int npoints);
  static double MLPRMSError(CMultilayerPerceptronShell &network,
                            CMatrixDouble &xy, const int npoints);
  static double MLPAvgError(CMultilayerPerceptronShell &network,
                            CMatrixDouble &xy, const int npoints);
  static double MLPAvgRelError(CMultilayerPerceptronShell &network,
                               CMatrixDouble &xy, const int npoints);
  static void MLPGrad(CMultilayerPerceptronShell &network, double &x[],
                      double &desiredy[], double &e, double &grad[]);
  static void MLPGradN(CMultilayerPerceptronShell &network, double &x[],
                       double &desiredy[], double &e, double &grad[]);
  static void MLPGradBatch(CMultilayerPerceptronShell &network,
                           CMatrixDouble &xy, const int ssize, double &e,
                           double &grad[]);
  static void MLPGradNBatch(CMultilayerPerceptronShell &network,
                            CMatrixDouble &xy, const int ssize, double &e,
                            double &grad[]);
  static void MLPHessianNBatch(CMultilayerPerceptronShell &network,
                               CMatrixDouble &xy, const int ssize, double &e,
                               double &grad[], CMatrixDouble &h);
  static void MLPHessianBatch(CMultilayerPerceptronShell &network,
                              CMatrixDouble &xy, const int ssize, double &e,
                              double &grad[], CMatrixDouble &h);

  static void MNLTrainH(CMatrixDouble &xy, const int npoints, const int nvars,
                        const int nclasses, int &info, CLogitModelShell &lm,
                        CMNLReportShell &rep);
  static void MNLProcess(CLogitModelShell &lm, double &x[], double &y[]);
  static void MNLProcessI(CLogitModelShell &lm, double &x[], double &y[]);
  static void MNLUnpack(CLogitModelShell &lm, CMatrixDouble &a, int &nvars,
                        int &nclasses);
  static void MNLPack(CMatrixDouble &a, const int nvars, const int nclasses,
                      CLogitModelShell &lm);
  static double MNLAvgCE(CLogitModelShell &lm, CMatrixDouble &xy,
                         const int npoints);
  static double MNLRelClsError(CLogitModelShell &lm, CMatrixDouble &xy,
                               const int npoints);
  static double MNLRMSError(CLogitModelShell &lm, CMatrixDouble &xy,
                            const int npoints);
  static double MNLAvgError(CLogitModelShell &lm, CMatrixDouble &xy,
                            const int npoints);
  static double MNLAvgRelError(CLogitModelShell &lm, CMatrixDouble &xy,
                               const int ssize);
  static int MNLClsError(CLogitModelShell &lm, CMatrixDouble &xy,
                         const int npoints);

  static void MCPDCreate(const int n, CMCPDStateShell &s);
  static void MCPDCreateEntry(const int n, const int entrystate,
                              CMCPDStateShell &s);
  static void MCPDCreateExit(const int n, const int exitstate,
                             CMCPDStateShell &s);
  static void MCPDCreateEntryExit(const int n, const int entrystate,
                                  const int exitstate, CMCPDStateShell &s);
  static void MCPDAddTrack(CMCPDStateShell &s, CMatrixDouble &xy, const int k);
  static void MCPDAddTrack(CMCPDStateShell &s, CMatrixDouble &xy);
  static void MCPDSetEC(CMCPDStateShell &s, CMatrixDouble &ec);
  static void MCPDAddEC(CMCPDStateShell &s, const int i, const int j,
                        const double c);
  static void MCPDSetBC(CMCPDStateShell &s, CMatrixDouble &bndl,
                        CMatrixDouble &bndu);
  static void MCPDAddBC(CMCPDStateShell &s, const int i, const int j,
                        const double bndl, const double bndu);
  static void MCPDSetLC(CMCPDStateShell &s, CMatrixDouble &c, int &ct[],
                        const int k);
  static void MCPDSetLC(CMCPDStateShell &s, CMatrixDouble &c, int &ct[]);
  static void MCPDSetTikhonovRegularizer(CMCPDStateShell &s, const double v);
  static void MCPDSetPrior(CMCPDStateShell &s, CMatrixDouble &pp);
  static void MCPDSetPredictionWeights(CMCPDStateShell &s, double &pw[]);
  static void MCPDSolve(CMCPDStateShell &s);
  static void MCPDResults(CMCPDStateShell &s, CMatrixDouble &p,
                          CMCPDReportShell &rep);

  static void MLPTrainLM(CMultilayerPerceptronShell &network, CMatrixDouble &xy,
                         const int npoints, const double decay,
                         const int restarts, int &info, CMLPReportShell &rep);
  static void MLPTrainLBFGS(CMultilayerPerceptronShell &network,
                            CMatrixDouble &xy, const int npoints,
                            const double decay, const int restarts,
                            const double wstep, int maxits, int &info,
                            CMLPReportShell &rep);
  static void MLPTrainES(CMultilayerPerceptronShell &network,
                         CMatrixDouble &trnxy, const int trnsize,
                         CMatrixDouble &valxy, const int valsize,
                         const double decay, const int restarts, int &info,
                         CMLPReportShell &rep);
  static void MLPKFoldCVLBFGS(CMultilayerPerceptronShell &network,
                              CMatrixDouble &xy, const int npoints,
                              const double decay, const int restarts,
                              const double wstep, const int maxits,
                              const int foldscount, int &info,
                              CMLPReportShell &rep, CMLPCVReportShell &cvrep);
  static void MLPKFoldCVLM(CMultilayerPerceptronShell &network,
                           CMatrixDouble &xy, const int npoints,
                           const double decay, const int restarts,
                           const int foldscount, int &info,
                           CMLPReportShell &rep, CMLPCVReportShell &cvrep);

  static void MLPECreate0(const int nin, const int nout, const int ensemblesize,
                          CMLPEnsembleShell &ensemble);
  static void MLPECreate1(const int nin, int nhid, const int nout,
                          const int ensemblesize, CMLPEnsembleShell &ensemble);
  static void MLPECreate2(const int nin, const int nhid1, const int nhid2,
                          const int nout, const int ensemblesize,
                          CMLPEnsembleShell &ensemble);
  static void MLPECreateB0(const int nin, const int nout, const double b,
                           const double d, const int ensemblesize,
                           CMLPEnsembleShell &ensemble);
  static void MLPECreateB1(const int nin, int nhid, const int nout,
                           const double b, const double d,
                           const int ensemblesize, CMLPEnsembleShell &ensemble);
  static void MLPECreateB2(const int nin, const int nhid1, const int nhid2,
                           const int nout, const double b, const double d,
                           const int ensemblesize, CMLPEnsembleShell &ensemble);
  static void MLPECreateR0(const int nin, const int nout, const double a,
                           const double b, const int ensemblesize,
                           CMLPEnsembleShell &ensemble);
  static void MLPECreateR1(const int nin, int nhid, const int nout,
                           const double a, const double b,
                           const int ensemblesize, CMLPEnsembleShell &ensemble);
  static void MLPECreateR2(const int nin, const int nhid1, const int nhid2,
                           const int nout, const double a, const double b,
                           const int ensemblesize, CMLPEnsembleShell &ensemble);
  static void MLPECreateC0(const int nin, const int nout,
                           const int ensemblesize, CMLPEnsembleShell &ensemble);
  static void MLPECreateC1(const int nin, int nhid, const int nout,
                           const int ensemblesize, CMLPEnsembleShell &ensemble);
  static void MLPECreateC2(const int nin, const int nhid1, const int nhid2,
                           const int nout, const int ensemblesize,
                           CMLPEnsembleShell &ensemble);
  static void MLPECreateFromNetwork(CMultilayerPerceptronShell &network,
                                    const int ensemblesize,
                                    CMLPEnsembleShell &ensemble);
  static void MLPERandomize(CMLPEnsembleShell &ensemble);
  static void MLPEProperties(CMLPEnsembleShell &ensemble, int &nin, int &nout);
  static bool MLPEIsSoftMax(CMLPEnsembleShell &ensemble);
  static void MLPEProcess(CMLPEnsembleShell &ensemble, double &x[],
                          double &y[]);
  static void MLPEProcessI(CMLPEnsembleShell &ensemble, double &x[],
                           double &y[]);
  static double MLPERelClsError(CMLPEnsembleShell &ensemble, CMatrixDouble &xy,
                                const int npoints);
  static double MLPEAvgCE(CMLPEnsembleShell &ensemble, CMatrixDouble &xy,
                          const int npoints);
  static double MLPERMSError(CMLPEnsembleShell &ensemble, CMatrixDouble &xy,
                             const int npoints);
  static double MLPEAvgError(CMLPEnsembleShell &ensemble, CMatrixDouble &xy,
                             const int npoints);
  static double MLPEAvgRelError(CMLPEnsembleShell &ensemble, CMatrixDouble &xy,
                                const int npoints);
  static void MLPEBaggingLM(CMLPEnsembleShell &ensemble, CMatrixDouble &xy,
                            const int npoints, const double decay,
                            const int restarts, int &info, CMLPReportShell &rep,
                            CMLPCVReportShell &ooberrors);
  static void MLPEBaggingLBFGS(CMLPEnsembleShell &ensemble, CMatrixDouble &xy,
                               const int npoints, const double decay,
                               const int restarts, const double wstep,
                               const int maxits, int &info,
                               CMLPReportShell &rep,
                               CMLPCVReportShell &ooberrors);
  static void MLPETrainES(CMLPEnsembleShell &ensemble, CMatrixDouble &xy,
                          const int npoints, const double decay,
                          const int restarts, int &info, CMLPReportShell &rep);

  static void PCABuildBasis(CMatrixDouble &x, const int npoints,
                            const int nvars, int &info, double &s2[],
                            CMatrixDouble &v);

  static void ODESolverRKCK(double &y[], const int n, double &x[], const int m,
                            const double eps, const double h,
                            CODESolverStateShell &state);
  static void ODESolverRKCK(double &y[], double &x[], const double eps,
                            const double h, CODESolverStateShell &state);
  static bool ODESolverIteration(CODESolverStateShell &state);
  static void ODESolverSolve(CODESolverStateShell &state,
                             CNDimensional_ODE_RP &diff, CObject &obj);
  static void ODESolverResults(CODESolverStateShell &state, int &m,
                               double &xtbl[], CMatrixDouble &ytbl,
                               CODESolverReportShell &rep);

  static void FFTC1D(al_complex &a[], const int n);
  static void FFTC1D(al_complex &a[]);
  static void FFTC1DInv(al_complex &a[], const int n);
  static void FFTC1DInv(al_complex &a[]);
  static void FFTR1D(double &a[], const int n, al_complex &f[]);
  static void FFTR1D(double &a[], al_complex &f[]);
  static void FFTR1DInv(al_complex &f[], const int n, double &a[]);
  static void FFTR1DInv(al_complex &f[], double &a[]);

  static void ConvC1D(al_complex &a[], const int m, al_complex &b[],
                      const int n, al_complex &r[]);
  static void ConvC1DInv(al_complex &a[], const int m, al_complex &b[],
                         const int n, al_complex &r[]);
  static void ConvC1DCircular(al_complex &s[], const int m, al_complex &r[],
                              const int n, al_complex &c[]);
  static void ConvC1DCircularInv(al_complex &a[], const int m, al_complex &b[],
                                 const int n, al_complex &r[]);
  static void ConvR1D(double &a[], const int m, double &b[], const int n,
                      double &r[]);
  static void ConvR1DInv(double &a[], const int m, double &b[], const int n,
                         double &r[]);
  static void ConvR1DCircular(double &s[], const int m, double &r[],
                              const int n, double &c[]);
  static void ConvR1DCircularInv(double &a[], const int m, double &b[],
                                 const int n, double &r[]);
  static void CorrC1D(al_complex &signal[], const int n, al_complex &pattern[],
                      const int m, al_complex &r[]);
  static void CorrC1DCircular(al_complex &signal[], const int m,
                              al_complex &pattern[], const int n,
                              al_complex &c[]);
  static void CorrR1D(double &signal[], const int n, double &pattern[],
                      const int m, double &r[]);
  static void CorrR1DCircular(double &signal[], const int m, double &pattern[],
                              const int n, double &c[]);

  static void FHTR1D(double &a[], const int n);
  static void FHTR1DInv(double &a[], const int n);

  static void GQGenerateRec(double &alpha[], double &beta[], const double mu0,
                            const int n, int &info, double &x[], double &w[]);
  static void GQGenerateGaussLobattoRec(double &alpha[], double &beta[],
                                        const double mu0, const double a,
                                        const double b, const int n, int &info,
                                        double &x[], double &w[]);
  static void GQGenerateGaussRadauRec(double &alpha[], double &beta[],
                                      const double mu0, const double a,
                                      const int n, int &info, double &x[],
                                      double &w[]);
  static void GQGenerateGaussLegendre(const int n, int &info, double &x[],
                                      double &w[]);
  static void GQGenerateGaussJacobi(const int n, const double alpha,
                                    const double beta, int &info, double &x[],
                                    double &w[]);
  static void GQGenerateGaussLaguerre(const int n, const double alpha,
                                      int &info, double &x[], double &w[]);
  static void GQGenerateGaussHermite(const int n, int &info, double &x[],
                                     double &w[]);

  static void GKQGenerateRec(double &alpha[], double &beta[], const double mu0,
                             const int n, int &info, double &x[],
                             double &wkronrod[], double &wgauss[]);
  static void GKQGenerateGaussLegendre(const int n, int &info, double &x[],
                                       double &wkronrod[], double &wgauss[]);
  static void GKQGenerateGaussJacobi(const int n, const double alpha,
                                     const double beta, int &info, double &x[],
                                     double &wkronrod[], double &wgauss[]);
  static void GKQLegendreCalc(const int n, int &info, double &x[],
                              double &wkronrod[], double &wgauss[]);
  static void GKQLegendreTbl(const int n, double &x[], double &wkronrod[],
                             double &wgauss[], double &eps);

  static void AutoGKSmooth(const double a, const double b,
                           CAutoGKStateShell &state);
  static void AutoGKSmoothW(const double a, const double b, double xwidth,
                            CAutoGKStateShell &state);
  static void AutoGKSingular(const double a, const double b, const double alpha,
                             const double beta, CAutoGKStateShell &state);
  static bool AutoGKIteration(CAutoGKStateShell &state);
  static void AutoGKIntegrate(CAutoGKStateShell &state, CIntegrator1_Func &func,
                              CObject &obj);
  static void AutoGKResults(CAutoGKStateShell &state, double &v,
                            CAutoGKReportShell &rep);

  static double IDWCalc(CIDWInterpolantShell &z, double &x[]);
  static void IDWBuildModifiedShepard(CMatrixDouble &xy, const int n,
                                      const int nx, const int d, const int nq,
                                      const int nw, CIDWInterpolantShell &z);
  static void IDWBuildModifiedShepardR(CMatrixDouble &xy, const int n,
                                       const int nx, const double r,
                                       CIDWInterpolantShell &z);
  static void IDWBuildNoisy(CMatrixDouble &xy, const int n, const int nx,
                            const int d, const int nq, const int nw,
                            CIDWInterpolantShell &z);

  static double BarycentricCalc(CBarycentricInterpolantShell &b,
                                const double t);
  static void BarycentricDiff1(CBarycentricInterpolantShell &b, const double t,
                               double &f, double &df);
  static void BarycentricDiff2(CBarycentricInterpolantShell &b, const double t,
                               double &f, double &df, double &d2f);
  static void BarycentricLinTransX(CBarycentricInterpolantShell &b,
                                   const double ca, const double cb);
  static void BarycentricLinTransY(CBarycentricInterpolantShell &b,
                                   const double ca, const double cb);
  static void BarycentricUnpack(CBarycentricInterpolantShell &b, int &n,
                                double &x[], double &y[], double &w[]);
  static void BarycentricBuildXYW(double &x[], double &y[], double &w[],
                                  const int n, CBarycentricInterpolantShell &b);
  static void BarycentricBuildFloaterHormann(double &x[], double &y[],
                                             const int n, const int d,
                                             CBarycentricInterpolantShell &b);

  static void PolynomialBar2Cheb(CBarycentricInterpolantShell &p,
                                 const double a, const double b, double &t[]);
  static void PolynomialCheb2Bar(double &t[], const int n, const double a,
                                 const double b,
                                 CBarycentricInterpolantShell &p);
  static void PolynomialCheb2Bar(double &t[], const double a, const double b,
                                 CBarycentricInterpolantShell &p);
  static void PolynomialBar2Pow(CBarycentricInterpolantShell &p, const double c,
                                const double s, double &a[]);
  static void PolynomialBar2Pow(CBarycentricInterpolantShell &p, double &a[]);
  static void PolynomialPow2Bar(double &a[], const int n, const double c,
                                const double s,
                                CBarycentricInterpolantShell &p);
  static void PolynomialPow2Bar(double &a[], CBarycentricInterpolantShell &p);
  static void PolynomialBuild(double &x[], double &y[], const int n,
                              CBarycentricInterpolantShell &p);
  static void PolynomialBuild(double &x[], double &y[],
                              CBarycentricInterpolantShell &p);
  static void PolynomialBuildEqDist(const double a, const double b, double &y[],
                                    const int n,
                                    CBarycentricInterpolantShell &p);
  static void PolynomialBuildEqDist(const double a, const double b, double &y[],
                                    CBarycentricInterpolantShell &p);
  static void PolynomialBuildCheb1(const double a, const double b, double &y[],
                                   const int n,
                                   CBarycentricInterpolantShell &p);
  static void PolynomialBuildCheb1(const double a, const double b, double &y[],
                                   CBarycentricInterpolantShell &p);
  static void PolynomialBuildCheb2(const double a, const double b, double &y[],
                                   const int n,
                                   CBarycentricInterpolantShell &p);
  static void PolynomialBuildCheb2(const double a, const double b, double &y[],
                                   CBarycentricInterpolantShell &p);
  static double PolynomialCalcEqDist(const double a, const double b,
                                     double &f[], const int n, const double t);
  static double PolynomialCalcEqDist(const double a, const double b,
                                     double &f[], const double t);
  static double PolynomialCalcCheb1(const double a, const double b, double &f[],
                                    const int n, const double t);
  static double PolynomialCalcCheb1(const double a, const double b, double &f[],
                                    const double t);
  static double PolynomialCalcCheb2(const double a, const double b, double &f[],
                                    const int n, const double t);
  static double PolynomialCalcCheb2(const double a, const double b, double &f[],
                                    const double t);

  static void Spline1DBuildLinear(double &x[], double &y[], const int n,
                                  CSpline1DInterpolantShell &c);
  static void Spline1DBuildLinear(double &x[], double &y[],
                                  CSpline1DInterpolantShell &c);
  static void Spline1DBuildCubic(double &x[], double &y[], const int n,
                                 const int boundltype, const double boundl,
                                 const int boundrtype, const double boundr,
                                 CSpline1DInterpolantShell &c);
  static void Spline1DBuildCubic(double &x[], double &y[],
                                 CSpline1DInterpolantShell &c);
  static void Spline1DGridDiffCubic(double &x[], double &y[], const int n,
                                    const int boundltype, const double boundl,
                                    const int boundrtype, const double boundr,
                                    double &d[]);
  static void Spline1DGridDiffCubic(double &x[], double &y[], double &d[]);
  static void Spline1DGridDiff2Cubic(double &x[], double &y[], const int n,
                                     const int boundltype, const double boundl,
                                     const int boundrtype, const double boundr,
                                     double &d1[], double &d2[]);
  static void Spline1DGridDiff2Cubic(double &x[], double &y[], double &d1[],
                                     double &d2[]);
  static void Spline1DConvCubic(double &x[], double &y[], const int n,
                                const int boundltype, const double boundl,
                                const int boundrtype, const double boundr,
                                double &x2[], int n2, double &y2[]);
  static void Spline1DConvCubic(double &x[], double &y[], double &x2[],
                                double &y2[]);
  static void Spline1DConvDiffCubic(double &x[], double &y[], const int n,
                                    const int boundltype, const double boundl,
                                    const int boundrtype, const double boundr,
                                    double &x2[], int n2, double &y2[],
                                    double &d2[]);
  static void Spline1DConvDiffCubic(double &x[], double &y[], double &x2[],
                                    double &y2[], double &d2[]);
  static void Spline1DConvDiff2Cubic(double &x[], double &y[], const int n,
                                     const int boundltype, const double boundl,
                                     const int boundrtype, const double boundr,
                                     double &x2[], const int n2, double &y2[],
                                     double &d2[], double &dd2[]);
  static void Spline1DConvDiff2Cubic(double &x[], double &y[], double &x2[],
                                     double &y2[], double &d2[], double &dd2[]);
  static void Spline1DBuildCatmullRom(double &x[], double &y[], const int n,
                                      const int boundtype, const double tension,
                                      CSpline1DInterpolantShell &c);
  static void Spline1DBuildCatmullRom(double &x[], double &y[],
                                      CSpline1DInterpolantShell &c);
  static void Spline1DBuildHermite(double &x[], double &y[], double &d[],
                                   const int n, CSpline1DInterpolantShell &c);
  static void Spline1DBuildHermite(double &x[], double &y[], double &d[],
                                   CSpline1DInterpolantShell &c);
  static void Spline1DBuildAkima(double &x[], double &y[], const int n,
                                 CSpline1DInterpolantShell &c);
  static void Spline1DBuildAkima(double &x[], double &y[],
                                 CSpline1DInterpolantShell &c);
  static double Spline1DCalc(CSpline1DInterpolantShell &c, const double x);
  static void Spline1DDiff(CSpline1DInterpolantShell &c, const double x,
                           double &s, double &ds, double &d2s);
  static void Spline1DUnpack(CSpline1DInterpolantShell &c, int &n,
                             CMatrixDouble &tbl);
  static void Spline1DLinTransX(CSpline1DInterpolantShell &c, const double a,
                                const double b);
  static void Spline1DLinTransY(CSpline1DInterpolantShell &c, const double a,
                                const double b);
  static double Spline1DIntegrate(CSpline1DInterpolantShell &c, const double x);

  static void PolynomialFit(double &x[], double &y[], const int n, const int m,
                            int &info, CBarycentricInterpolantShell &p,
                            CPolynomialFitReportShell &rep);
  static void PolynomialFit(double &x[], double &y[], const int m, int &info,
                            CBarycentricInterpolantShell &p,
                            CPolynomialFitReportShell &rep);
  static void PolynomialFitWC(double &x[], double &y[], double &w[],
                              const int n, double &xc[], double &yc[],
                              int &dc[], const int k, const int m, int &info,
                              CBarycentricInterpolantShell &p,
                              CPolynomialFitReportShell &rep);
  static void PolynomialFitWC(double &x[], double &y[], double &w[],
                              double &xc[], double &yc[], int &dc[],
                              const int m, int &info,
                              CBarycentricInterpolantShell &p,
                              CPolynomialFitReportShell &rep);
  static void BarycentricFitFloaterHormannWC(
      double &x[], double &y[], double &w[], const int n, double &xc[],
      double &yc[], int &dc[], const int k, const int m, int &info,
      CBarycentricInterpolantShell &b, CBarycentricFitReportShell &rep);
  static void BarycentricFitFloaterHormann(double &x[], double &y[],
                                           const int n, const int m, int &info,
                                           CBarycentricInterpolantShell &b,
                                           CBarycentricFitReportShell &rep);
  static void Spline1DFitPenalized(double &x[], double &y[], const int n,
                                   const int m, const double rho, int &info,
                                   CSpline1DInterpolantShell &s,
                                   CSpline1DFitReportShell &rep);
  static void Spline1DFitPenalized(double &x[], double &y[], const int m,
                                   const double rho, int &info,
                                   CSpline1DInterpolantShell &s,
                                   CSpline1DFitReportShell &rep);
  static void Spline1DFitPenalizedW(double &x[], double &y[], double &w[],
                                    const int n, const int m, const double rho,
                                    int &info, CSpline1DInterpolantShell &s,
                                    CSpline1DFitReportShell &rep);
  static void Spline1DFitPenalizedW(double &x[], double &y[], double &w[],
                                    const int m, const double rho, int &info,
                                    CSpline1DInterpolantShell &s,
                                    CSpline1DFitReportShell &rep);
  static void Spline1DFitCubicWC(double &x[], double &y[], double &w[],
                                 const int n, double &xc[], double &yc[],
                                 int &dc[], const int k, const int m, int &info,
                                 CSpline1DInterpolantShell &s,
                                 CSpline1DFitReportShell &rep);
  static void Spline1DFitCubicWC(double &x[], double &y[], double &w[],
                                 double &xc[], double &yc[], int &dc[],
                                 const int m, int &info,
                                 CSpline1DInterpolantShell &s,
                                 CSpline1DFitReportShell &rep);
  static void Spline1DFitHermiteWC(double &x[], double &y[], double &w[],
                                   const int n, double &xc[], double &yc[],
                                   int &dc[], const int k, const int m,
                                   int &info, CSpline1DInterpolantShell &s,
                                   CSpline1DFitReportShell &rep);
  static void Spline1DFitHermiteWC(double &x[], double &y[], double &w[],
                                   double &xc[], double &yc[], int &dc[],
                                   const int m, int &info,
                                   CSpline1DInterpolantShell &s,
                                   CSpline1DFitReportShell &rep);
  static void Spline1DFitCubic(double &x[], double &y[], const int n,
                               const int m, int &info,
                               CSpline1DInterpolantShell &s,
                               CSpline1DFitReportShell &rep);
  static void Spline1DFitCubic(double &x[], double &y[], const int m, int &info,
                               CSpline1DInterpolantShell &s,
                               CSpline1DFitReportShell &rep);
  static void Spline1DFitHermite(double &x[], double &y[], const int n,
                                 const int m, int &info,
                                 CSpline1DInterpolantShell &s,
                                 CSpline1DFitReportShell &rep);
  static void Spline1DFitHermite(double &x[], double &y[], const int m,
                                 int &info, CSpline1DInterpolantShell &s,
                                 CSpline1DFitReportShell &rep);
  static void LSFitLinearW(double &y[], double &w[], CMatrixDouble &fmatrix,
                           const int n, const int m, int &info, double &c[],
                           CLSFitReportShell &rep);
  static void LSFitLinearW(double &y[], double &w[], CMatrixDouble &fmatrix,
                           int &info, double &c[], CLSFitReportShell &rep);
  static void LSFitLinearWC(double &y[], double &w[], CMatrixDouble &fmatrix,
                            CMatrixDouble &cmatrix, const int n, const int m,
                            const int k, int &info, double &c[],
                            CLSFitReportShell &rep);
  static void LSFitLinearWC(double &y[], double &w[], CMatrixDouble &fmatrix,
                            CMatrixDouble &cmatrix, int &info, double &c[],
                            CLSFitReportShell &rep);
  static void LSFitLinear(double &y[], CMatrixDouble &fmatrix, const int n,
                          const int m, int &info, double &c[],
                          CLSFitReportShell &rep);
  static void LSFitLinear(double &y[], CMatrixDouble &fmatrix, int &info,
                          double &c[], CLSFitReportShell &rep);
  static void LSFitLinearC(double &y[], CMatrixDouble &fmatrix,
                           CMatrixDouble &cmatrix, const int n, const int m,
                           const int k, int &info, double &c[],
                           CLSFitReportShell &rep);
  static void LSFitLinearC(double &y[], CMatrixDouble &fmatrix,
                           CMatrixDouble &cmatrix, int &info, double &c[],
                           CLSFitReportShell &rep);
  static void LSFitCreateWF(CMatrixDouble &x, double &y[], double &w[],
                            double &c[], const int n, const int m, const int k,
                            const double diffstep, CLSFitStateShell &state);
  static void LSFitCreateWF(CMatrixDouble &x, double &y[], double &w[],
                            double &c[], const double diffstep,
                            CLSFitStateShell &state);
  static void LSFitCreateF(CMatrixDouble &x, double &y[], double &c[],
                           const int n, const int m, const int k,
                           const double diffstep, CLSFitStateShell &state);
  static void LSFitCreateF(CMatrixDouble &x, double &y[], double &c[],
                           const double diffstep, CLSFitStateShell &state);
  static void LSFitCreateWFG(CMatrixDouble &x, double &y[], double &w[],
                             double &c[], const int n, const int m, const int k,
                             const bool cheapfg, CLSFitStateShell &state);
  static void LSFitCreateWFG(CMatrixDouble &x, double &y[], double &w[],
                             double &c[], const bool cheapfg,
                             CLSFitStateShell &state);
  static void LSFitCreateFG(CMatrixDouble &x, double &y[], double &c[],
                            const int n, const int m, const int k,
                            const bool cheapfg, CLSFitStateShell &state);
  static void LSFitCreateFG(CMatrixDouble &x, double &y[], double &c[],
                            const bool cheapfg, CLSFitStateShell &state);
  static void LSFitCreateWFGH(CMatrixDouble &x, double &y[], double &w[],
                              double &c[], const int n, const int m,
                              const int k, CLSFitStateShell &state);
  static void LSFitCreateWFGH(CMatrixDouble &x, double &y[], double &w[],
                              double &c[], CLSFitStateShell &state);
  static void LSFitCreateFGH(CMatrixDouble &x, double &y[], double &c[],
                             const int n, const int m, const int k,
                             CLSFitStateShell &state);
  static void LSFitCreateFGH(CMatrixDouble &x, double &y[], double &c[],
                             CLSFitStateShell &state);
  static void LSFitSetCond(CLSFitStateShell &state, const double epsf,
                           const double epsx, const int maxits);
  static void LSFitSetStpMax(CLSFitStateShell &state, const double stpmax);
  static void LSFitSetXRep(CLSFitStateShell &state, const bool needxrep);
  static void LSFitSetScale(CLSFitStateShell &state, double &s[]);
  static void LSFitSetBC(CLSFitStateShell &state, double &bndl[],
                         double &bndu[]);
  static bool LSFitIteration(CLSFitStateShell &state);
  static void LSFitFit(CLSFitStateShell &state, CNDimensional_PFunc &func,
                       CNDimensional_Rep &rep, bool rep_status, CObject &obj);
  static void LSFitFit(CLSFitStateShell &state, CNDimensional_PFunc &func,
                       CNDimensional_PGrad &grad, CNDimensional_Rep &rep,
                       bool rep_status, CObject &obj);
  static void LSFitFit(CLSFitStateShell &state, CNDimensional_PFunc &func,
                       CNDimensional_PGrad &grad, CNDimensional_PHess &hess,
                       CNDimensional_Rep &rep, bool rep_status, CObject &obj);
  static void LSFitResults(CLSFitStateShell &state, int &info, double &c[],
                           CLSFitReportShell &rep);

  static void PSpline2Build(CMatrixDouble &xy, const int n, const int st,
                            const int pt, CPSpline2InterpolantShell &p);
  static void PSpline3Build(CMatrixDouble &xy, const int n, const int st,
                            const int pt, CPSpline3InterpolantShell &p);
  static void PSpline2BuildPeriodic(CMatrixDouble &xy, const int n,
                                    const int st, const int pt,
                                    CPSpline2InterpolantShell &p);
  static void PSpline3BuildPeriodic(CMatrixDouble &xy, const int n,
                                    const int st, const int pt,
                                    CPSpline3InterpolantShell &p);
  static void PSpline2ParameterValues(CPSpline2InterpolantShell &p, int &n,
                                      double &t[]);
  static void PSpline3ParameterValues(CPSpline3InterpolantShell &p, int &n,
                                      double &t[]);
  static void PSpline2Calc(CPSpline2InterpolantShell &p, const double t,
                           double &x, double &y);
  static void PSpline3Calc(CPSpline3InterpolantShell &p, const double t,
                           double &x, double &y, double &z);
  static void PSpline2Tangent(CPSpline2InterpolantShell &p, const double t,
                              double &x, double &y);
  static void PSpline3Tangent(CPSpline3InterpolantShell &p, const double t,
                              double &x, double &y, double &z);
  static void PSpline2Diff(CPSpline2InterpolantShell &p, const double t,
                           double &x, double &dx, double &y, double &dy);
  static void PSpline3Diff(CPSpline3InterpolantShell &p, const double t,
                           double &x, double &dx, double &y, double &dy,
                           double &z, double &dz);
  static void PSpline2Diff2(CPSpline2InterpolantShell &p, const double t,
                            double &x, double &dx, double &d2x, double &y,
                            double &dy, double &d2y);
  static void PSpline3Diff2(CPSpline3InterpolantShell &p, const double t,
                            double &x, double &dx, double &d2x, double &y,
                            double &dy, double &d2y, double &z, double &dz,
                            double &d2z);
  static double PSpline2ArcLength(CPSpline2InterpolantShell &p, const double a,
                                  const double b);
  static double PSpline3ArcLength(CPSpline3InterpolantShell &p, const double a,
                                  const double b);

  static void Spline2DBuildBilinear(double &x[], double &y[], CMatrixDouble &f,
                                    const int m, const int n,
                                    CSpline2DInterpolantShell &c);
  static void Spline2DBuildBicubic(double &x[], double &y[], CMatrixDouble &f,
                                   const int m, const int n,
                                   CSpline2DInterpolantShell &c);
  static double Spline2DCalc(CSpline2DInterpolantShell &c, const double x,
                             const double y);
  static void Spline2DDiff(CSpline2DInterpolantShell &c, const double x,
                           const double y, double &f, double &fx, double &fy,
                           double &fxy);
  static void Spline2DUnpack(CSpline2DInterpolantShell &c, int &m, int &n,
                             CMatrixDouble &tbl);
  static void Spline2DLinTransXY(CSpline2DInterpolantShell &c, const double ax,
                                 const double bx, const double ay,
                                 const double by);
  static void Spline2DLinTransF(CSpline2DInterpolantShell &c, const double a,
                                const double b);
  static void Spline2DResampleBicubic(CMatrixDouble &a, const int oldheight,
                                      const int oldwidth, CMatrixDouble &b,
                                      const int newheight, const int newwidth);
  static void Spline2DResampleBilinear(CMatrixDouble &a, const int oldheight,
                                       const int oldwidth, CMatrixDouble &b,
                                       const int newheight, const int newwidth);

  static void CMatrixTranspose(const int m, const int n, CMatrixComplex &a,
                               const int ia, const int ja, CMatrixComplex &b,
                               const int ib, const int jb);
  static void RMatrixTranspose(const int m, const int n, CMatrixDouble &a,
                               const int ia, const int ja, CMatrixDouble &b,
                               const int ib, const int jb);
  static void CMatrixCopy(const int m, const int n, CMatrixComplex &a,
                          const int ia, const int ja, CMatrixComplex &b,
                          const int ib, const int jb);
  static void RMatrixCopy(const int m, const int n, CMatrixDouble &a,
                          const int ia, const int ja, CMatrixDouble &b,
                          const int ib, const int jb);
  static void CMatrixRank1(const int m, const int n, CMatrixComplex &a,
                           const int ia, const int ja, al_complex &u[],
                           const int iu, al_complex &v[], const int iv);
  static void RMatrixRank1(const int m, const int n, CMatrixDouble &a,
                           const int ia, const int ja, double &u[],
                           const int iu, double &v[], const int iv);
  static void CMatrixMVect(const int m, const int n, CMatrixComplex &a,
                           const int ia, const int ja, const int opa,
                           al_complex &x[], const int ix, al_complex &y[],
                           const int iy);
  static void RMatrixMVect(const int m, const int n, CMatrixDouble &a,
                           const int ia, const int ja, const int opa,
                           double &x[], const int ix, double &y[],
                           const int iy);
  static void CMatrixRightTrsM(const int m, const int n, CMatrixComplex &a,
                               const int i1, const int j1, const bool isupper,
                               const bool isunit, const int optype,
                               CMatrixComplex &x, const int i2, const int j2);
  static void CMatrixLeftTrsM(const int m, const int n, CMatrixComplex &a,
                              const int i1, const int j1, const bool isupper,
                              const bool isunit, const int optype,
                              CMatrixComplex &x, const int i2, const int j2);
  static void RMatrixRightTrsM(const int m, const int n, CMatrixDouble &a,
                               const int i1, const int j1, const bool isupper,
                               const bool isunit, const int optype,
                               CMatrixDouble &x, const int i2, const int j2);
  static void RMatrixLeftTrsM(const int m, const int n, CMatrixDouble &a,
                              const int i1, const int j1, const bool isupper,
                              const bool isunit, const int optype,
                              CMatrixDouble &x, const int i2, const int j2);
  static void CMatrixSyrk(const int n, const int k, const double alpha,
                          CMatrixComplex &a, const int ia, const int ja,
                          const int optypea, const double beta,
                          CMatrixComplex &c, const int ic, const int jc,
                          const bool isupper);
  static void RMatrixSyrk(const int n, const int k, const double alpha,
                          CMatrixDouble &a, const int ia, const int ja,
                          const int optypea, const double beta,
                          CMatrixDouble &c, const int ic, const int jc,
                          const bool isupper);
  static void CMatrixGemm(const int m, const int n, const int k,
                          al_complex &alpha, CMatrixComplex &a, const int ia,
                          const int ja, const int optypea, CMatrixComplex &b,
                          const int ib, const int jb, const int optypeb,
                          al_complex &beta, CMatrixComplex &c, const int ic,
                          const int jc);
  static void RMatrixGemm(const int m, const int n, const int k,
                          const double alpha, CMatrixDouble &a, const int ia,
                          const int ja, const int optypea, CMatrixDouble &b,
                          const int ib, const int jb, const int optypeb,
                          const double beta, CMatrixDouble &c, const int ic,
                          const int jc);

  static void RMatrixQR(CMatrixDouble &a, const int m, const int n,
                        double &tau[]);
  static void RMatrixLQ(CMatrixDouble &a, const int m, const int n,
                        double &tau[]);
  static void CMatrixQR(CMatrixComplex &a, const int m, const int n,
                        al_complex &tau[]);
  static void CMatrixLQ(CMatrixComplex &a, const int m, const int n,
                        al_complex &tau[]);
  static void RMatrixQRUnpackQ(CMatrixDouble &a, const int m, const int n,
                               double &tau[], const int qcolumns,
                               CMatrixDouble &q);
  static void RMatrixQRUnpackR(CMatrixDouble &a, const int m, const int n,
                               CMatrixDouble &r);
  static void RMatrixLQUnpackQ(CMatrixDouble &a, const int m, const int n,
                               double &tau[], const int qrows,
                               CMatrixDouble &q);
  static void RMatrixLQUnpackL(CMatrixDouble &a, const int m, const int n,
                               CMatrixDouble &l);
  static void CMatrixQRUnpackQ(CMatrixComplex &a, const int m, const int n,
                               al_complex &tau[], const int qcolumns,
                               CMatrixComplex &q);
  static void CMatrixQRUnpackR(CMatrixComplex &a, const int m, const int n,
                               CMatrixComplex &r);
  static void CMatrixLQUnpackQ(CMatrixComplex &a, const int m, const int n,
                               al_complex &tau[], const int qrows,
                               CMatrixComplex &q);
  static void CMatrixLQUnpackL(CMatrixComplex &a, const int m, const int n,
                               CMatrixComplex &l);
  static void RMatrixBD(CMatrixDouble &a, const int m, const int n,
                        double &tauq[], double &taup[]);
  static void RMatrixBDUnpackQ(CMatrixDouble &qp, const int m, const int n,
                               double &tauq[], const int qcolumns,
                               CMatrixDouble &q);
  static void RMatrixBDMultiplyByQ(CMatrixDouble &qp, const int m, const int n,
                                   double &tauq[], CMatrixDouble &z,
                                   const int zrows, const int zcolumns,
                                   const bool fromtheright,
                                   const bool dotranspose);
  static void RMatrixBDUnpackPT(CMatrixDouble &qp, const int m, const int n,
                                double &taup[], const int ptrows,
                                CMatrixDouble &pt);
  static void RMatrixBDMultiplyByP(CMatrixDouble &qp, const int m, const int n,
                                   double &taup[], CMatrixDouble &z,
                                   const int zrows, const int zcolumns,
                                   const bool fromtheright,
                                   const bool dotranspose);
  static void RMatrixBDUnpackDiagonals(CMatrixDouble &b, const int m,
                                       const int n, bool &isupper, double &d[],
                                       double &e[]);
  static void RMatrixHessenberg(CMatrixDouble &a, const int n, double &tau[]);
  static void RMatrixHessenbergUnpackQ(CMatrixDouble &a, const int n,
                                       double &tau[], CMatrixDouble &q);
  static void RMatrixHessenbergUnpackH(CMatrixDouble &a, const int n,
                                       CMatrixDouble &h);
  static void SMatrixTD(CMatrixDouble &a, const int n, const bool isupper,
                        double &tau[], double &d[], double &e[]);
  static void SMatrixTDUnpackQ(CMatrixDouble &a, const int n,
                               const bool isupper, double &tau[],
                               CMatrixDouble &q);
  static void HMatrixTD(CMatrixComplex &a, const int n, const bool isupper,
                        al_complex &tau[], double &d[], double &e[]);
  static void HMatrixTDUnpackQ(CMatrixComplex &a, const int n,
                               const bool isupper, al_complex &tau[],
                               CMatrixComplex &q);

  static bool SMatrixEVD(CMatrixDouble &a, const int n, int zneeded,
                         const bool isupper, double &d[], CMatrixDouble &z);
  static bool SMatrixEVDR(CMatrixDouble &a, const int n, int zneeded,
                          const bool isupper, double b1, double b2, int &m,
                          double &w[], CMatrixDouble &z);
  static bool SMatrixEVDI(CMatrixDouble &a, const int n, int zneeded,
                          const bool isupper, const int i1, const int i2,
                          double &w[], CMatrixDouble &z);
  static bool HMatrixEVD(CMatrixComplex &a, const int n, const int zneeded,
                         const bool isupper, double &d[], CMatrixComplex &z);
  static bool HMatrixEVDR(CMatrixComplex &a, const int n, const int zneeded,
                          const bool isupper, double b1, double b2, int &m,
                          double &w[], CMatrixComplex &z);
  static bool HMatrixEVDI(CMatrixComplex &a, const int n, const int zneeded,
                          const bool isupper, const int i1, const int i2,
                          double &w[], CMatrixComplex &z);
  static bool SMatrixTdEVD(double &d[], double &e[], const int n,
                           const int zneeded, CMatrixDouble &z);
  static bool SMatrixTdEVDR(double &d[], double &e[], const int n,
                            const int zneeded, const double a, const double b,
                            int &m, CMatrixDouble &z);
  static bool SMatrixTdEVDI(double &d[], double &e[], const int n,
                            const int zneeded, const int i1, const int i2,
                            CMatrixDouble &z);
  static bool RMatrixEVD(CMatrixDouble &a, const int n, const int vneeded,
                         double &wr[], double &wi[], CMatrixDouble &vl,
                         CMatrixDouble &vr);

  static void RMatrixRndOrthogonal(const int n, CMatrixDouble &a);
  static void RMatrixRndCond(const int n, const double c, CMatrixDouble &a);
  static void CMatrixRndOrthogonal(const int n, CMatrixComplex &a);
  static void CMatrixRndCond(const int n, const double c, CMatrixComplex &a);
  static void SMatrixRndCond(const int n, const double c, CMatrixDouble &a);
  static void SPDMatrixRndCond(const int n, const double c, CMatrixDouble &a);
  static void HMatrixRndCond(const int n, const double c, CMatrixComplex &a);
  static void HPDMatrixRndCond(const int n, const double c, CMatrixComplex &a);
  static void RMatrixRndOrthogonalFromTheRight(CMatrixDouble &a, const int m,
                                               const int n);
  static void RMatrixRndOrthogonalFromTheLeft(CMatrixDouble &a, const int m,
                                              const int n);
  static void CMatrixRndOrthogonalFromTheRight(CMatrixComplex &a, const int m,
                                               const int n);
  static void CMatrixRndOrthogonalFromTheLeft(CMatrixComplex &a, const int m,
                                              const int n);
  static void SMatrixRndMultiply(CMatrixDouble &a, const int n);
  static void HMatrixRndMultiply(CMatrixComplex &a, const int n);

  static void RMatrixLU(CMatrixDouble &a, const int m, const int n,
                        int &pivots[]);
  static void CMatrixLU(CMatrixComplex &a, const int m, const int n,
                        int &pivots[]);
  static bool HPDMatrixCholesky(CMatrixComplex &a, const int n,
                                const bool isupper);
  static bool SPDMatrixCholesky(CMatrixDouble &a, const int n,
                                const bool isupper);

  static double RMatrixRCond1(CMatrixDouble &a, const int n);
  static double RMatrixRCondInf(CMatrixDouble &a, const int n);
  static double SPDMatrixRCond(CMatrixDouble &a, const int n,
                               const bool isupper);
  static double RMatrixTrRCond1(CMatrixDouble &a, const int n,
                                const bool isupper, const bool isunit);
  static double RMatrixTrRCondInf(CMatrixDouble &a, const int n,
                                  const bool isupper, const bool isunit);
  static double HPDMatrixRCond(CMatrixComplex &a, const int n,
                               const bool isupper);
  static double CMatrixRCond1(CMatrixComplex &a, const int n);
  static double CMatrixRCondInf(CMatrixComplex &a, const int n);
  static double RMatrixLURCond1(CMatrixDouble &lua, const int n);
  static double RMatrixLURCondInf(CMatrixDouble &lua, const int n);
  static double SPDMatrixCholeskyRCond(CMatrixDouble &a, const int n,
                                       const bool isupper);
  static double HPDMatrixCholeskyRCond(CMatrixComplex &a, const int n,
                                       const bool isupper);
  static double CMatrixLURCond1(CMatrixComplex &lua, const int n);
  static double CMatrixLURCondInf(CMatrixComplex &lua, const int n);
  static double CMatrixTrRCond1(CMatrixComplex &a, const int n,
                                const bool isupper, const bool isunit);
  static double CMatrixTrRCondInf(CMatrixComplex &a, const int n,
                                  const bool isupper, const bool isunit);

  static void RMatrixLUInverse(CMatrixDouble &a, int &pivots[], const int n,
                               int &info, CMatInvReportShell &rep);
  static void RMatrixLUInverse(CMatrixDouble &a, int &pivots[], int &info,
                               CMatInvReportShell &rep);
  static void RMatrixInverse(CMatrixDouble &a, const int n, int &info,
                             CMatInvReportShell &rep);
  static void RMatrixInverse(CMatrixDouble &a, int &info,
                             CMatInvReportShell &rep);
  static void CMatrixLUInverse(CMatrixComplex &a, int &pivots[], const int n,
                               int &info, CMatInvReportShell &rep);
  static void CMatrixLUInverse(CMatrixComplex &a, int &pivots[], int &info,
                               CMatInvReportShell &rep);
  static void CMatrixInverse(CMatrixComplex &a, const int n, int &info,
                             CMatInvReportShell &rep);
  static void CMatrixInverse(CMatrixComplex &a, int &info,
                             CMatInvReportShell &rep);
  static void SPDMatrixCholeskyInverse(CMatrixDouble &a, const int n,
                                       const bool isupper, int &info,
                                       CMatInvReportShell &rep);
  static void SPDMatrixCholeskyInverse(CMatrixDouble &a, int &info,
                                       CMatInvReportShell &rep);
  static void SPDMatrixInverse(CMatrixDouble &a, const int n,
                               const bool isupper, int &info,
                               CMatInvReportShell &rep);
  static void SPDMatrixInverse(CMatrixDouble &a, int &info,
                               CMatInvReportShell &rep);
  static void HPDMatrixCholeskyInverse(CMatrixComplex &a, const int n,
                                       const bool isupper, int &info,
                                       CMatInvReportShell &rep);
  static void HPDMatrixCholeskyInverse(CMatrixComplex &a, int &info,
                                       CMatInvReportShell &rep);
  static void HPDMatrixInverse(CMatrixComplex &a, const int n,
                               const bool isupper, int &info,
                               CMatInvReportShell &rep);
  static void HPDMatrixInverse(CMatrixComplex &a, int &info,
                               CMatInvReportShell &rep);
  static void RMatrixTrInverse(CMatrixDouble &a, const int n,
                               const bool isupper, const bool isunit, int &info,
                               CMatInvReportShell &rep);
  static void RMatrixTrInverse(CMatrixDouble &a, const bool isupper, int &info,
                               CMatInvReportShell &rep);
  static void CMatrixTrInverse(CMatrixComplex &a, const int n,
                               const bool isupper, const bool isunit, int &info,
                               CMatInvReportShell &rep);
  static void CMatrixTrInverse(CMatrixComplex &a, const bool isupper, int &info,
                               CMatInvReportShell &rep);

  static bool RMatrixBdSVD(double &d[], double &e[], const int n,
                           const bool isupper,
                           bool isfractionalaccuracyrequired, CMatrixDouble &u,
                           const int nru, CMatrixDouble &c, const int ncc,
                           CMatrixDouble &vt, const int ncvt);

  static bool RMatrixSVD(CMatrixDouble &a, const int m, const int n,
                         const int uneeded, const int vtneeded,
                         const int additionalmemory, double &w[],
                         CMatrixDouble &u, CMatrixDouble &vt);

  static double RMatrixLUDet(CMatrixDouble &a, int &pivots[], const int n);
  static double RMatrixLUDet(CMatrixDouble &a, int &pivots[]);
  static double RMatrixDet(CMatrixDouble &a, const int n);
  static double RMatrixDet(CMatrixDouble &a);
  static al_complex CMatrixLUDet(CMatrixComplex &a, int &pivots[], const int n);
  static al_complex CMatrixLUDet(CMatrixComplex &a, int &pivots[]);
  static al_complex CMatrixDet(CMatrixComplex &a, const int n);
  static al_complex CMatrixDet(CMatrixComplex &a);
  static double SPDMatrixCholeskyDet(CMatrixDouble &a, const int n);
  static double SPDMatrixCholeskyDet(CMatrixDouble &a);
  static double SPDMatrixDet(CMatrixDouble &a, const int n, const bool isupper);
  static double SPDMatrixDet(CMatrixDouble &a);

  static bool SMatrixGEVD(CMatrixDouble &a, const int n, const bool isuppera,
                          CMatrixDouble &b, const bool isupperb,
                          const int zneeded, const int problemtype, double &d[],
                          CMatrixDouble &z);
  static bool SMatrixGEVDReduce(CMatrixDouble &a, const int n,
                                const bool isuppera, CMatrixDouble &b,
                                const bool isupperb, const int problemtype,
                                CMatrixDouble &r, bool &isupperr);

  static void RMatrixInvUpdateSimple(CMatrixDouble &inva, const int n,
                                     const int updrow, const int updcolumn,
                                     const double updval);
  static void RMatrixInvUpdateRow(CMatrixDouble &inva, const int n,
                                  const int updrow, double &v[]);
  static void RMatrixInvUpdateColumn(CMatrixDouble &inva, const int n,
                                     const int updcolumn, double &u[]);
  static void RMatrixInvUpdateUV(CMatrixDouble &inva, const int n, double &u[],
                                 double &v[]);

  static bool RMatrixSchur(CMatrixDouble &a, const int n, CMatrixDouble &s);

  static void MinCGCreate(const int n, double &x[], CMinCGStateShell &state);
  static void MinCGCreate(double &x[], CMinCGStateShell &state);
  static void MinCGCreateF(const int n, double &x[], double diffstep,
                           CMinCGStateShell &state);
  static void MinCGCreateF(double &x[], double diffstep,
                           CMinCGStateShell &state);
  static void MinCGSetCond(CMinCGStateShell &state, double epsg, double epsf,
                           double epsx, int maxits);
  static void MinCGSetScale(CMinCGStateShell &state, double &s[]);
  static void MinCGSetXRep(CMinCGStateShell &state, bool needxrep);
  static void MinCGSetCGType(CMinCGStateShell &state, int cgtype);
  static void MinCGSetStpMax(CMinCGStateShell &state, double stpmax);
  static void MinCGSuggestStep(CMinCGStateShell &state, double stp);
  static void MinCGSetPrecDefault(CMinCGStateShell &state);
  static void MinCGSetPrecDiag(CMinCGStateShell &state, double &d[]);
  static void MinCGSetPrecScale(CMinCGStateShell &state);
  static bool MinCGIteration(CMinCGStateShell &state);
  static void MinCGOptimize(CMinCGStateShell &state, CNDimensional_Func &func,
                            CNDimensional_Rep &rep, bool rep_status,
                            CObject &obj);
  static void MinCGOptimize(CMinCGStateShell &state, CNDimensional_Grad &grad,
                            CNDimensional_Rep &rep, bool rep_status,
                            CObject &obj);
  static void MinCGResults(CMinCGStateShell &state, double &x[],
                           CMinCGReportShell &rep);
  static void MinCGResultsBuf(CMinCGStateShell &state, double &x[],
                              CMinCGReportShell &rep);
  static void MinCGRestartFrom(CMinCGStateShell &state, double &x[]);

  static void MinBLEICCreate(const int n, double &x[],
                             CMinBLEICStateShell &state);
  static void MinBLEICCreate(double &x[], CMinBLEICStateShell &state);
  static void MinBLEICCreateF(const int n, double &x[], double diffstep,
                              CMinBLEICStateShell &state);
  static void MinBLEICCreateF(double &x[], double diffstep,
                              CMinBLEICStateShell &state);
  static void MinBLEICSetBC(CMinBLEICStateShell &state, double &bndl[],
                            double &bndu[]);
  static void MinBLEICSetLC(CMinBLEICStateShell &state, CMatrixDouble &c,
                            int &ct[], const int k);
  static void MinBLEICSetLC(CMinBLEICStateShell &state, CMatrixDouble &c,
                            int &ct[]);
  static void MinBLEICSetInnerCond(CMinBLEICStateShell &state,
                                   const double epsg, const double epsf,
                                   const double epsx);
  static void MinBLEICSetOuterCond(CMinBLEICStateShell &state,
                                   const double epsx, const double epsi);
  static void MinBLEICSetScale(CMinBLEICStateShell &state, double &s[]);
  static void MinBLEICSetPrecDefault(CMinBLEICStateShell &state);
  static void MinBLEICSetPrecDiag(CMinBLEICStateShell &state, double &d[]);
  static void MinBLEICSetPrecScale(CMinBLEICStateShell &state);
  static void MinBLEICSetMaxIts(CMinBLEICStateShell &state, const int maxits);
  static void MinBLEICSetXRep(CMinBLEICStateShell &state, bool needxrep);
  static void MinBLEICSetStpMax(CMinBLEICStateShell &state, double stpmax);
  static bool MinBLEICIteration(CMinBLEICStateShell &state);
  static void MinBLEICOptimize(CMinBLEICStateShell &state,
                               CNDimensional_Func &func, CNDimensional_Rep &rep,
                               bool rep_status, CObject &obj);
  static void MinBLEICOptimize(CMinBLEICStateShell &state,
                               CNDimensional_Grad &grad, CNDimensional_Rep &rep,
                               bool rep_status, CObject &obj);
  static void MinBLEICResults(CMinBLEICStateShell &state, double &x[],
                              CMinBLEICReportShell &rep);
  static void MinBLEICResultsBuf(CMinBLEICStateShell &state, double &x[],
                                 CMinBLEICReportShell &rep);
  static void MinBLEICRestartFrom(CMinBLEICStateShell &state, double &x[]);

  static void MinLBFGSCreate(const int n, const int m, double &x[],
                             CMinLBFGSStateShell &state);
  static void MinLBFGSCreate(const int m, double &x[],
                             CMinLBFGSStateShell &state);
  static void MinLBFGSCreateF(const int n, const int m, double &x[],
                              const double diffstep,
                              CMinLBFGSStateShell &state);
  static void MinLBFGSCreateF(const int m, double &x[], const double diffstep,
                              CMinLBFGSStateShell &state);
  static void MinLBFGSSetCond(CMinLBFGSStateShell &state, const double epsg,
                              const double epsf, const double epsx,
                              const int maxits);
  static void MinLBFGSSetXRep(CMinLBFGSStateShell &state, const bool needxrep);
  static void MinLBFGSSetStpMax(CMinLBFGSStateShell &state,
                                const double stpmax);
  static void MinLBFGSSetScale(CMinLBFGSStateShell &state, double &s[]);
  static void MinLBFGSSetPrecDefault(CMinLBFGSStateShell &state);
  static void MinLBFGSSetPrecCholesky(CMinLBFGSStateShell &state,
                                      CMatrixDouble &p, const bool isupper);
  static void MinLBFGSSetPrecDiag(CMinLBFGSStateShell &state, double &d[]);
  static void MinLBFGSSetPrecScale(CMinLBFGSStateShell &state);
  static bool MinLBFGSIteration(CMinLBFGSStateShell &state);
  static void MinLBFGSOptimize(CMinLBFGSStateShell &state,
                               CNDimensional_Func &func, CNDimensional_Rep &rep,
                               bool rep_status, CObject &obj);
  static void MinLBFGSOptimize(CMinLBFGSStateShell &state,
                               CNDimensional_Grad &grad, CNDimensional_Rep &rep,
                               bool rep_status, CObject &obj);
  static void MinLBFGSResults(CMinLBFGSStateShell &state, double &x[],
                              CMinLBFGSReportShell &rep);
  static void MinLBFGSresultsbuf(CMinLBFGSStateShell &state, double &x[],
                                 CMinLBFGSReportShell &rep);
  static void MinLBFGSRestartFrom(CMinLBFGSStateShell &state, double &x[]);

  static void MinQPCreate(const int n, CMinQPStateShell &state);
  static void MinQPSetLinearTerm(CMinQPStateShell &state, double &b[]);
  static void MinQPSetQuadraticTerm(CMinQPStateShell &state, CMatrixDouble &a,
                                    const bool isupper);
  static void MinQPSetQuadraticTerm(CMinQPStateShell &state, CMatrixDouble &a);
  static void MinQPSetStartingPoint(CMinQPStateShell &state, double &x[]);
  static void MinQPSetOrigin(CMinQPStateShell &state, double &xorigin[]);
  static void MinQPSetAlgoCholesky(CMinQPStateShell &state);
  static void MinQPSetBC(CMinQPStateShell &state, double &bndl[],
                         double &bndu[]);
  static void MinQPOptimize(CMinQPStateShell &state);
  static void MinQPResults(CMinQPStateShell &state, double &x[],
                           CMinQPReportShell &rep);
  static void MinQPResultsBuf(CMinQPStateShell &state, double &x[],
                              CMinQPReportShell &rep);

  static void MinLMCreateVJ(const int n, const int m, double &x[],
                            CMinLMStateShell &state);
  static void MinLMCreateVJ(const int m, double &x[], CMinLMStateShell &state);
  static void MinLMCreateV(const int n, const int m, double &x[],
                           double diffstep, CMinLMStateShell &state);
  static void MinLMCreateV(const int m, double &x[], const double diffstep,
                           CMinLMStateShell &state);
  static void MinLMCreateFGH(const int n, double &x[], CMinLMStateShell &state);
  static void MinLMCreateFGH(double &x[], CMinLMStateShell &state);
  static void MinLMSetCond(CMinLMStateShell &state, const double epsg,
                           const double epsf, const double epsx,
                           const int maxits);
  static void MinLMSetXRep(CMinLMStateShell &state, const bool needxrep);
  static void MinLMSetStpMax(CMinLMStateShell &state, const double stpmax);
  static void MinLMSetScale(CMinLMStateShell &state, double &s[]);
  static void MinLMSetBC(CMinLMStateShell &state, double &bndl[],
                         double &bndu[]);
  static void MinLMSetAccType(CMinLMStateShell &state, const int acctype);
  static bool MinLMIteration(CMinLMStateShell &state);
  static void MinLMOptimize(CMinLMStateShell &state, CNDimensional_FVec &fvec,
                            CNDimensional_Rep &rep, bool rep_status,
                            CObject &obj);
  static void MinLMOptimize(CMinLMStateShell &state, CNDimensional_FVec &fvec,
                            CNDimensional_Jac &jac, CNDimensional_Rep &rep,
                            bool rep_status, CObject &obj);
  static void MinLMOptimize(CMinLMStateShell &state, CNDimensional_Func &func,
                            CNDimensional_Grad &grad, CNDimensional_Hess &hess,
                            CNDimensional_Rep &rep, bool rep_status,
                            CObject &obj);
  static void MinLMOptimize(CMinLMStateShell &state, CNDimensional_Func &func,
                            CNDimensional_Jac &jac, CNDimensional_Rep &rep,
                            bool rep_status, CObject &obj);
  static void MinLMOptimize(CMinLMStateShell &state, CNDimensional_Func &func,
                            CNDimensional_Grad &grad, CNDimensional_Jac &jac,
                            CNDimensional_Rep &rep, bool rep_status,
                            CObject &obj);
  static void MinLMResults(CMinLMStateShell &state, double &x[],
                           CMinLMReportShell &rep);
  static void MinLMResultsBuf(CMinLMStateShell &state, double &x[],
                              CMinLMReportShell &rep);
  static void MinLMRestartFrom(CMinLMStateShell &state, double &x[]);
  static void MinLMCreateVGJ(const int n, const int m, double &x[],
                             CMinLMStateShell &state);
  static void MinLMCreateVGJ(const int m, double &x[], CMinLMStateShell &state);
  static void MinLMCreateFGJ(const int n, const int m, double &x[],
                             CMinLMStateShell &state);
  static void MinLMCreateFGJ(const int m, double &x[], CMinLMStateShell &state);
  static void MinLMCreateFJ(const int n, const int m, double &x[],
                            CMinLMStateShell &state);
  static void MinLMCreateFJ(const int m, double &x[], CMinLMStateShell &state);

  static void MinLBFGSSetDefaultPreconditioner(CMinLBFGSStateShell &state);
  static void MinLBFGSSetCholeskyPreconditioner(CMinLBFGSStateShell &state,
                                                CMatrixDouble &p, bool isupper);
  static void MinBLEICSetBarrierWidth(CMinBLEICStateShell &state,
                                      const double mu);
  static void MinBLEICSetBarrierDecay(CMinBLEICStateShell &state,
                                      const double mudecay);
  static void MinASACreate(const int n, double &x[], double &bndl[],
                           double &bndu[], CMinASAStateShell &state);
  static void MinASACreate(double &x[], double &bndl[], double &bndu[],
                           CMinASAStateShell &state);
  static void MinASASetCond(CMinASAStateShell &state, const double epsg,
                            const double epsf, const double epsx,
                            const int maxits);
  static void MinASASetXRep(CMinASAStateShell &state, const bool needxrep);
  static void MinASASetAlgorithm(CMinASAStateShell &state, const int algotype);
  static void MinASASetStpMax(CMinASAStateShell &state, const double stpmax);
  static bool MinASAIteration(CMinASAStateShell &state);
  static void MinASAOptimize(CMinASAStateShell &state, CNDimensional_Grad &grad,
                             CNDimensional_Rep &rep, bool rep_status,
                             CObject &obj);
  static void MinASAResults(CMinASAStateShell &state, double &x[],
                            CMinASAReportShell &rep);
  static void MinASAResultsBuf(CMinASAStateShell &state, double &x[],
                               CMinASAReportShell &rep);
  static void MinASARestartFrom(CMinASAStateShell &state, double &x[],
                                double &bndl[], double &bndu[]);

  static void RMatrixSolve(CMatrixDouble &a, const int n, double &b[],
                           int &info, CDenseSolverReportShell &rep,
                           double &x[]);
  static void RMatrixSolveM(CMatrixDouble &a, const int n, CMatrixDouble &b,
                            const int m, const bool rfs, int &info,
                            CDenseSolverReportShell &rep, CMatrixDouble &x);
  static void RMatrixLUSolve(CMatrixDouble &lua, int &p[], const int n,
                             double &b[], int &info,
                             CDenseSolverReportShell &rep, double &x[]);
  static void RMatrixLUSolveM(CMatrixDouble &lua, int &p[], const int n,
                              CMatrixDouble &b, const int m, int &info,
                              CDenseSolverReportShell &rep, CMatrixDouble &x);
  static void RMatrixMixedSolve(CMatrixDouble &a, CMatrixDouble &lua, int &p[],
                                const int n, double &b[], int &info,
                                CDenseSolverReportShell &rep, double &x[]);
  static void RMatrixMixedSolveM(CMatrixDouble &a, CMatrixDouble &lua, int &p[],
                                 const int n, CMatrixDouble &b, const int m,
                                 int &info, CDenseSolverReportShell &rep,
                                 CMatrixDouble &x);
  static void CMatrixSolveM(CMatrixComplex &a, const int n, CMatrixComplex &b,
                            const int m, const bool rfs, int &info,
                            CDenseSolverReportShell &rep, CMatrixComplex &x);
  static void CMatrixSolve(CMatrixComplex &a, const int n, al_complex &b[],
                           int &info, CDenseSolverReportShell &rep,
                           al_complex &x[]);
  static void CMatrixLUSolveM(CMatrixComplex &lua, int &p[], const int n,
                              CMatrixComplex &b, const int m, int &info,
                              CDenseSolverReportShell &rep, CMatrixComplex &x);
  static void CMatrixLUSolve(CMatrixComplex &lua, int &p[], const int n,
                             al_complex &b[], int &info,
                             CDenseSolverReportShell &rep, al_complex &x[]);
  static void CMatrixMixedSolveM(CMatrixComplex &a, CMatrixComplex &lua,
                                 int &p[], const int n, CMatrixComplex &b,
                                 const int m, int &info,
                                 CDenseSolverReportShell &rep,
                                 CMatrixComplex &x);
  static void CMatrixMixedSolve(CMatrixComplex &a, CMatrixComplex &lua,
                                int &p[], const int n, al_complex &b[],
                                int &info, CDenseSolverReportShell &rep,
                                al_complex &x[]);
  static void SPDMatrixSolveM(CMatrixDouble &a, const int n, const bool isupper,
                              CMatrixDouble &b, const int m, int &info,
                              CDenseSolverReportShell &rep, CMatrixDouble &x);
  static void SPDMatrixSolve(CMatrixDouble &a, const int n, const bool isupper,
                             double &b[], int &info,
                             CDenseSolverReportShell &rep, double &x[]);
  static void SPDMatrixCholeskySolveM(CMatrixDouble &cha, const int n,
                                      const bool isupper, CMatrixDouble &b,
                                      const int m, int &info,
                                      CDenseSolverReportShell &rep,
                                      CMatrixDouble &x);
  static void SPDMatrixCholeskySolve(CMatrixDouble &cha, const int n,
                                     const bool isupper, double &b[], int &info,
                                     CDenseSolverReportShell &rep, double &x[]);
  static void HPDMatrixSolveM(CMatrixComplex &a, const int n,
                              const bool isupper, CMatrixComplex &b,
                              const int m, int &info,
                              CDenseSolverReportShell &rep, CMatrixComplex &x);
  static void HPDMatrixSolve(CMatrixComplex &a, const int n, const bool isupper,
                             al_complex &b[], int &info,
                             CDenseSolverReportShell &rep, al_complex &x[]);
  static void HPDMatrixCholeskySolveM(CMatrixComplex &cha, const int n,
                                      const bool isupper, CMatrixComplex &b,
                                      const int m, int &info,
                                      CDenseSolverReportShell &rep,
                                      CMatrixComplex &x);
  static void HPDMatrixCholeskySolve(CMatrixComplex &cha, const int n,
                                     const bool isupper, al_complex &b[],
                                     int &info, CDenseSolverReportShell &rep,
                                     al_complex &x[]);
  static void RMatrixSolveLS(CMatrixDouble &a, const int nrows, const int ncols,
                             double &b[], const double threshold, int &info,
                             CDenseSolverLSReportShell &rep, double &x[]);

  static void NlEqCreateLM(const int n, const int m, double &x[],
                           CNlEqStateShell &state);
  static void NlEqCreateLM(const int m, double &x[], CNlEqStateShell &state);
  static void NlEqSetCond(CNlEqStateShell &state, const double epsf,
                          const int maxits);
  static void NlEqSetXRep(CNlEqStateShell &state, const bool needxrep);
  static void NlEqSetStpMax(CNlEqStateShell &state, const double stpmax);
  static bool NlEqIteration(CNlEqStateShell &state);
  static void NlEqSolve(CNlEqStateShell &state, CNDimensional_Func &func,
                        CNDimensional_Jac &jac, CNDimensional_Rep &rep,
                        bool rep_status, CObject &obj);
  static void NlEqResults(CNlEqStateShell &state, double &x[],
                          CNlEqReportShell &rep);
  static void NlEqResultsBuf(CNlEqStateShell &state, double &x[],
                             CNlEqReportShell &rep);
  static void NlEqRestartFrom(CNlEqStateShell &state, double &x[]);

  static double GammaFunction(const double x);
  static double LnGamma(const double x, double &sgngam);

  static double ErrorFunction(const double x);
  static double ErrorFunctionC(const double x);
  static double NormalDistribution(const double x);
  static double InvErF(double e);
  static double InvNormalDistribution(const double y0);

  static double IncompleteGamma(const double a, const double x);
  static double IncompleteGammaC(const double a, const double x);
  static double InvIncompleteGammaC(const double a, const double y0);

  static void Airy(const double x, double &ai, double &aip, double &bi,
                   double &bip);

  static double BesselJ0(const double x);
  static double BesselJ1(const double x);
  static double BesselJN(const int n, const double x);
  static double BesselY0(const double x);
  static double BesselY1(const double x);
  static double BesselYN(const int n, const double x);
  static double BesselI0(const double x);
  static double BesselI1(const double x);
  static double BesselK0(const double x);
  static double BesselK1(const double x);
  static double BesselKN(const int nn, const double x);

  static double Beta(const double a, const double b);
  static double IncompleteBeta(const double a, const double b, const double x);
  static double InvIncompleteBeta(const double a, const double b, double y);

  static double BinomialDistribution(const int k, const int n, const double p);
  static double BinomialComplDistribution(const int k, const int n,
                                          const double p);
  static double InvBinomialDistribution(const int k, const int n,
                                        const double y);

  static double ChebyshevCalculate(int r, const int n, const double x);
  static double ChebyshevSum(double &c[], const int r, const int n,
                             const double x);
  static void ChebyshevCoefficients(const int n, double &c[]);
  static void FromChebyshev(double &a[], const int n, double &b[]);

  static double ChiSquareDistribution(const double v, const double x);
  static double ChiSquareComplDistribution(const double v, const double x);
  static double InvChiSquareDistribution(const double v, const double y);

  static double DawsonIntegral(const double x);

  static double EllipticIntegralK(const double m);
  static double EllipticIntegralKhighPrecision(const double m1);
  static double IncompleteEllipticIntegralK(const double phi, const double m);
  static double EllipticIntegralE(const double m);
  static double IncompleteEllipticIntegralE(const double phi, const double m);

  static double ExponentialIntegralEi(const double x);
  static double ExponentialIntegralEn(const double x, const int n);

  static double FDistribution(const int a, const int b, const double x);
  static double FComplDistribution(const int a, const int b, const double x);
  static double InvFDistribution(const int a, const int b, const double y);

  static void FresnelIntegral(const double x, double &c, double &s);

  static double HermiteCalculate(const int n, const double x);
  static double HermiteSum(double &c[], const int n, const double x);
  static void HermiteCoefficients(const int n, double &c[]);

  static void JacobianEllipticFunctions(const double u, const double m,
                                        double &sn, double &cn, double &dn,
                                        double &ph);

  static double LaguerreCalculate(const int n, const double x);
  static double LaguerreSum(double &c[], const int n, const double x);
  static void LaguerreCoefficients(const int n, double &c[]);

  static double LegendreCalculate(const int n, const double x);
  static double LegendreSum(double &c[], const int n, const double x);
  static void LegendreCoefficients(const int n, double &c[]);

  static double PoissonDistribution(const int k, const double m);
  static double PoissonComplDistribution(const int k, const double m);
  static double InvPoissonDistribution(const int k, const double y);

  static double Psi(const double x);

  static double StudenttDistribution(const int k, const double t);
  static double InvStudenttDistribution(const int k, const double p);

  static void SineCosineIntegrals(const double x, double &si, double &ci);
  static void HyperbolicSineCosineIntegrals(const double x, double &shi,
                                            double &chi);

  static void SampleMoments(const double &x[], const int n, double &mean,
                            double &variance, double &skewness,
                            double &kurtosis);
  static void SampleMoments(const double &x[], double &mean, double &variance,
                            double &skewness, double &kurtosis);
  static void SampleAdev(const double &x[], const int n, double &adev);
  static void SampleAdev(const double &x[], double &adev);
  static void SampleMedian(const double &x[], const int n, double &median);
  static void SampleMedian(const double &x[], double &median);
  static void SamplePercentile(const double &x[], const int n, const double p,
                               double &v);
  static void SamplePercentile(const double &x[], const double p, double &v);
  static double Cov2(const double &x[], const double &y[], const int n);
  static double Cov2(const double &x[], const double &y[]);
  static double PearsonCorr2(const double &x[], const double &y[], const int n);
  static double PearsonCorr2(const double &x[], const double &y[]);
  static double SpearmanCorr2(const double &x[], const double &y[],
                              const int n);
  static double SpearmanCorr2(const double &x[], const double &y[]);
  static void CovM(const CMatrixDouble &x, const int n, const int m,
                   CMatrixDouble &c);
  static void CovM(const CMatrixDouble &x, CMatrixDouble &c);
  static void PearsonCorrM(const CMatrixDouble &x, const int n, const int m,
                           CMatrixDouble &c);
  static void PearsonCorrM(CMatrixDouble &x, CMatrixDouble &c);
  static void SpearmanCorrM(const CMatrixDouble &x, const int n, const int m,
                            CMatrixDouble &c);
  static void SpearmanCorrM(const CMatrixDouble &x, CMatrixDouble &c);
  static void CovM2(const CMatrixDouble &x, const CMatrixDouble &y, const int n,
                    const int m1, const int m2, CMatrixDouble &c);
  static void CovM2(const CMatrixDouble &x, const CMatrixDouble &y,
                    CMatrixDouble &c);
  static void PearsonCorrM2(const CMatrixDouble &x, const CMatrixDouble &y,
                            const int n, const int m1, const int m2,
                            CMatrixDouble &c);
  static void PearsonCorrM2(const CMatrixDouble &x, const CMatrixDouble &y,
                            CMatrixDouble &c);
  static void SpearmanCorrM2(const CMatrixDouble &x, const CMatrixDouble &y,
                             const int n, const int m1, const int m2,
                             CMatrixDouble &c);
  static void SpearmanCorrM2(const CMatrixDouble &x, const CMatrixDouble &y,
                             CMatrixDouble &c);

  static void PearsonCorrelationSignificance(const double r, const int n,
                                             double &bothTails,
                                             double &leftTail,
                                             double &rightTail);
  static void SpearmanRankCorrelationSignificance(const double r, const int n,
                                                  double &bothTails,
                                                  double &leftTail,
                                                  double &rightTail);

  static void JarqueBeraTest(const double &x[], const int n, double &p);

  static void MannWhitneyUTest(const double &x[], const int n,
                               const double &y[], const int m,
                               double &bothTails, double &leftTail,
                               double &rightTail);

  static void OneSampleSignTest(const double &x[], const int n,
                                const double median, double &bothTails,
                                double &leftTail, double &rightTail);

  static void StudentTest1(const double &x[], const int n, const double mean,
                           double &bothTails, double &leftTail,
                           double &rightTail);
  static void StudentTest2(const double &x[], const int n, const double &y[],
                           const int m, double &bothTails, double &leftTail,
                           double &rightTail);
  static void UnequalVarianceTest(const double &x[], const int n,
                                  const double &y[], const int m,
                                  double &bothTails, double &leftTail,
                                  double &rightTail);

  static void FTest(const double &x[], const int n, const double &y[],
                    const int m, double &bothTails, double &leftTail,
                    double &rightTail);
  static void OneSampleVarianceTest(double &x[], int n, double variance,
                                    double &bothTails, double &leftTail,
                                    double &rightTail);

  static void WilcoxonSignedRankTest(const double &x[], const int n,
                                     const double e, double &bothTails,
                                     double &leftTail, double &rightTail);
};

CAlglib::CAlglib(void) {
}

CAlglib::~CAlglib(void) {
}

static void CAlglib::HQRndRandomize(CHighQualityRandStateShell &state) {

  CHighQualityRand::HQRndRandomize(state.GetInnerObj());

  return;
}

static void CAlglib::HQRndSeed(const int s1, const int s2,
                               CHighQualityRandStateShell &state) {

  CHighQualityRand::HQRndSeed(s1, s2, state.GetInnerObj());

  return;
}

static double CAlglib::HQRndUniformR(CHighQualityRandStateShell &state) {

  return (CHighQualityRand::HQRndUniformR(state.GetInnerObj()));
}

static int CAlglib::HQRndUniformI(CHighQualityRandStateShell &state,
                                  const int n) {

  return (CHighQualityRand::HQRndUniformI(state.GetInnerObj(), n));
}

static double CAlglib::HQRndNormal(CHighQualityRandStateShell &state) {

  return (CHighQualityRand::HQRndNormal(state.GetInnerObj()));
}

static void CAlglib::HQRndUnit2(CHighQualityRandStateShell &state, double &x,
                                double &y) {

  x = 0;
  y = 0;

  CHighQualityRand::HQRndUnit2(state.GetInnerObj(), x, y);

  return;
}

static void CAlglib::HQRndNormal2(CHighQualityRandStateShell &state, double &x1,
                                  double &x2) {

  x1 = 0;
  x2 = 0;

  CHighQualityRand::HQRndNormal2(state.GetInnerObj(), x1, x2);

  return;
}

static double CAlglib::HQRndExponential(CHighQualityRandStateShell &state,
                                        const double lambdav) {

  return (CHighQualityRand::HQRndExponential(state.GetInnerObj(), lambdav));
}

static void CAlglib::KDTreeSerialize(CKDTreeShell &obj, string &s_out) {

  CSerializer s;
  s.Alloc_Start();

  CNearestNeighbor::KDTreeAlloc(s, obj.GetInnerObj());
  s.SStart_Str();

  CNearestNeighbor::KDTreeSerialize(s, obj.GetInnerObj());
  s.Stop();

  s_out = s.Get_String();
}

static void CAlglib::KDTreeUnserialize(string s_in, CKDTreeShell &obj) {

  CSerializer s;
  s.UStart_Str(s_in);

  CNearestNeighbor::KDTreeUnserialize(s, obj.GetInnerObj());
  s.Stop();
}

static void CAlglib::KDTreeBuild(CMatrixDouble &xy, const int n, const int nx,
                                 const int ny, const int normtype,
                                 CKDTreeShell &kdt) {

  CNearestNeighbor::KDTreeBuild(xy, n, nx, ny, normtype, kdt.GetInnerObj());

  return;
}

static void CAlglib::KDTreeBuild(CMatrixDouble &xy, const int nx, const int ny,
                                 const int normtype, CKDTreeShell &kdt) {

  int n = CAp::Rows(xy);

  CNearestNeighbor::KDTreeBuild(xy, n, nx, ny, normtype, kdt.GetInnerObj());

  return;
}

static void CAlglib::KDTreeBuildTagged(CMatrixDouble &xy, int &tags[],
                                       const int n, const int nx, const int ny,
                                       const int normtype, CKDTreeShell &kdt) {

  CNearestNeighbor::KDTreeBuildTagged(xy, tags, n, nx, ny, normtype,
                                      kdt.GetInnerObj());

  return;
}

static void CAlglib::KDTreeBuildTagged(CMatrixDouble &xy, int &tags[],
                                       const int nx, const int ny,
                                       const int normtype, CKDTreeShell &kdt) {

  int n;
  if ((CAp::Rows(xy) != CAp::Len(tags))) {
    Print(__FUNCTION__ + ": looks like one of arguments has wrong size");
    CAp::exception_happened = true;
    return;
  }

  n = CAp::Rows(xy);

  CNearestNeighbor::KDTreeBuildTagged(xy, tags, n, nx, ny, normtype,
                                      kdt.GetInnerObj());

  return;
}

static int CAlglib::KDTreeQueryKNN(CKDTreeShell &kdt, double &x[], const int k,
                                   const bool selfmatch) {

  return (CNearestNeighbor::KDTreeQueryKNN(kdt.GetInnerObj(), x, k, selfmatch));
}

static int CAlglib::KDTreeQueryKNN(CKDTreeShell &kdt, double &x[],
                                   const int k) {

  bool selfmatch = true;

  return (CNearestNeighbor::KDTreeQueryKNN(kdt.GetInnerObj(), x, k, selfmatch));
}

static int CAlglib::KDTreeQueryRNN(CKDTreeShell &kdt, double &x[],
                                   const double r, const bool selfmatch) {

  return (CNearestNeighbor::KDTreeQueryRNN(kdt.GetInnerObj(), x, r, selfmatch));
}

static int CAlglib::KDTreeQueryRNN(CKDTreeShell &kdt, double &x[],
                                   const double r) {

  bool selfmatch = true;

  return (CNearestNeighbor::KDTreeQueryRNN(kdt.GetInnerObj(), x, r, selfmatch));
}

static int CAlglib::KDTreeQueryAKNN(CKDTreeShell &kdt, double &x[], const int k,
                                    const bool selfmatch, const double eps) {

  return (CNearestNeighbor::KDTreeQueryAKNN(kdt.GetInnerObj(), x, k, selfmatch,
                                            eps));
}

static int CAlglib::KDTreeQueryAKNN(CKDTreeShell &kdt, double &x[], const int k,
                                    const double eps) {

  bool selfmatch = true;

  return (CNearestNeighbor::KDTreeQueryAKNN(kdt.GetInnerObj(), x, k, selfmatch,
                                            eps));
}

static void CAlglib::KDTreeQueryResultsX(CKDTreeShell &kdt, CMatrixDouble &x) {

  CNearestNeighbor::KDTreeQueryResultsX(kdt.GetInnerObj(), x);

  return;
}

static void CAlglib::KDTreeQueryResultsXY(CKDTreeShell &kdt,
                                          CMatrixDouble &xy) {

  CNearestNeighbor::KDTreeQueryResultsXY(kdt.GetInnerObj(), xy);

  return;
}

static void CAlglib::KDTreeQueryResultsTags(CKDTreeShell &kdt, int &tags[]) {

  CNearestNeighbor::KDTreeQueryResultsTags(kdt.GetInnerObj(), tags);

  return;
}

static void CAlglib::KDTreeQueryResultsDistances(CKDTreeShell &kdt,
                                                 double &r[]) {

  CNearestNeighbor::KDTreeQueryResultsDistances(kdt.GetInnerObj(), r);

  return;
}

static void CAlglib::KDTreeQueryResultsXI(CKDTreeShell &kdt, CMatrixDouble &x) {

  CNearestNeighbor::KDTreeQueryResultsXI(kdt.GetInnerObj(), x);

  return;
}

static void CAlglib::KDTreeQueryResultsXYI(CKDTreeShell &kdt,
                                           CMatrixDouble &xy) {

  CNearestNeighbor::KDTreeQueryResultsXYI(kdt.GetInnerObj(), xy);

  return;
}

static void CAlglib::KDTreeQueryResultsTagsI(CKDTreeShell &kdt, int &tags[]) {

  CNearestNeighbor::KDTreeQueryResultsTagsI(kdt.GetInnerObj(), tags);

  return;
}

static void CAlglib::KDTreeQueryResultsDistancesI(CKDTreeShell &kdt,
                                                  double &r[]) {

  CNearestNeighbor::KDTreeQueryResultsDistancesI(kdt.GetInnerObj(), r);

  return;
}

static void CAlglib::DSOptimalSplit2(double &a[], int &c[], const int n,
                                     int &info, double &threshold, double &pal,
                                     double &pbl, double &par, double &pbr,
                                     double &cve) {

  info = 0;
  threshold = 0;
  pal = 0;
  pbl = 0;
  par = 0;
  pbr = 0;
  cve = 0;

  CBdSS::DSOptimalSplit2(a, c, n, info, threshold, pal, pbl, par, pbr, cve);

  return;
}

static void CAlglib::DSOptimalSplit2Fast(double &a[], int &c[], int &tiesbuf[],
                                         int &cntbuf[], double &bufr[],
                                         int &bufi[], const int n, const int nc,
                                         const double alpha, int &info,
                                         double &threshold, double &rms,
                                         double &cvrms) {

  info = 0;
  threshold = 0;
  rms = 0;
  cvrms = 0;

  CBdSS::DSOptimalSplit2Fast(a, c, tiesbuf, cntbuf, bufr, bufi, n, nc, alpha,
                             info, threshold, rms, cvrms);

  return;
}

static void CAlglib::DFSerialize(CDecisionForestShell &obj, string &s_out) {

  CSerializer s;

  s.Alloc_Start();

  CDForest::DFAlloc(s, obj.GetInnerObj());

  s.SStart_Str();

  CDForest::DFSerialize(s, obj.GetInnerObj());

  s.Stop();

  s_out = s.Get_String();
}

static void CAlglib::DFUnserialize(const string s_in,
                                   CDecisionForestShell &obj) {

  CSerializer s;

  s.UStart_Str(s_in);

  CDForest::DFUnserialize(s, obj.GetInnerObj());

  s.Stop();
}

static void CAlglib::DFBuildRandomDecisionForest(
    CMatrixDouble &xy, const int npoints, const int nvars, const int nclasses,
    const int ntrees, const double r, int &info, CDecisionForestShell &df,
    CDFReportShell &rep) {

  info = 0;

  CDForest::DFBuildRandomDecisionForest(xy, npoints, nvars, nclasses, ntrees, r,
                                        info, df.GetInnerObj(),
                                        rep.GetInnerObj());

  return;
}

static void CAlglib::DFBuildRandomDecisionForestX1(
    CMatrixDouble &xy, const int npoints, const int nvars, const int nclasses,
    const int ntrees, int nrndvars, const double r, int &info,
    CDecisionForestShell &df, CDFReportShell &rep) {

  info = 0;

  CDForest::DFBuildRandomDecisionForestX1(xy, npoints, nvars, nclasses, ntrees,
                                          nrndvars, r, info, df.GetInnerObj(),
                                          rep.GetInnerObj());

  return;
}

static void CAlglib::DFProcess(CDecisionForestShell &df, double &x[],
                               double &y[]) {

  CDForest::DFProcess(df.GetInnerObj(), x, y);

  return;
}

static void CAlglib::DFProcessI(CDecisionForestShell &df, double &x[],
                                double &y[]) {

  CDForest::DFProcessI(df.GetInnerObj(), x, y);

  return;
}

static double CAlglib::DFRelClsError(CDecisionForestShell &df,
                                     CMatrixDouble &xy, const int npoints) {

  return (CDForest::DFRelClsError(df.GetInnerObj(), xy, npoints));
}

static double CAlglib::DFAvgCE(CDecisionForestShell &df, CMatrixDouble &xy,
                               const int npoints) {

  return (CDForest::DFAvgCE(df.GetInnerObj(), xy, npoints));
}

static double CAlglib::DFRMSError(CDecisionForestShell &df, CMatrixDouble &xy,
                                  const int npoints) {

  return (CDForest::DFRMSError(df.GetInnerObj(), xy, npoints));
}

static double CAlglib::DFAvgError(CDecisionForestShell &df, CMatrixDouble &xy,
                                  const int npoints) {

  return (CDForest::DFAvgError(df.GetInnerObj(), xy, npoints));
}

static double CAlglib::DFAvgRelError(CDecisionForestShell &df,
                                     CMatrixDouble &xy, const int npoints) {

  return (CDForest::DFAvgRelError(df.GetInnerObj(), xy, npoints));
}

static void CAlglib::KMeansGenerate(CMatrixDouble &xy, const int npoints,
                                    const int nvars, const int k,
                                    const int restarts, int &info,
                                    CMatrixDouble &c, int &xyc[]) {

  info = 0;

  CKMeans::KMeansGenerate(xy, npoints, nvars, k, restarts, info, c, xyc);

  return;
}

static void CAlglib::FisherLDA(CMatrixDouble &xy, const int npoints,
                               const int nvars, const int nclasses, int &info,
                               double &w[]) {

  info = 0;

  CLDA::FisherLDA(xy, npoints, nvars, nclasses, info, w);

  return;
}

static void CAlglib::FisherLDAN(CMatrixDouble &xy, const int npoints,
                                const int nvars, const int nclasses, int &info,
                                CMatrixDouble &w) {

  info = 0;

  CLDA::FisherLDAN(xy, npoints, nvars, nclasses, info, w);

  return;
}

static void CAlglib::LRBuild(CMatrixDouble &xy, const int npoints,
                             const int nvars, int &info, CLinearModelShell &lm,
                             CLRReportShell &ar) {

  info = 0;

  CLinReg::LRBuild(xy, npoints, nvars, info, lm.GetInnerObj(),
                   ar.GetInnerObj());

  return;
}

static void CAlglib::LRBuildS(CMatrixDouble &xy, double &s[], const int npoints,
                              const int nvars, int &info, CLinearModelShell &lm,
                              CLRReportShell &ar) {

  info = 0;

  CLinReg::LRBuildS(xy, s, npoints, nvars, info, lm.GetInnerObj(),
                    ar.GetInnerObj());

  return;
}

static void CAlglib::LRBuildZS(CMatrixDouble &xy, double &s[],
                               const int npoints, const int nvars, int &info,
                               CLinearModelShell &lm, CLRReportShell &ar) {

  info = 0;

  CLinReg::LRBuildZS(xy, s, npoints, nvars, info, lm.GetInnerObj(),
                     ar.GetInnerObj());

  return;
}

static void CAlglib::LRBuildZ(CMatrixDouble &xy, const int npoints,
                              const int nvars, int &info, CLinearModelShell &lm,
                              CLRReportShell &ar) {

  info = 0;

  CLinReg::LRBuildZ(xy, npoints, nvars, info, lm.GetInnerObj(),
                    ar.GetInnerObj());

  return;
}

static void CAlglib::LRUnpack(CLinearModelShell &lm, double &v[], int &nvars) {

  nvars = 0;

  CLinReg::LRUnpack(lm.GetInnerObj(), v, nvars);

  return;
}

static void CAlglib::LRPack(double &v[], const int nvars,
                            CLinearModelShell &lm) {

  CLinReg::LRPack(v, nvars, lm.GetInnerObj());

  return;
}

static double CAlglib::LRProcess(CLinearModelShell &lm, double &x[]) {

  return (CLinReg::LRProcess(lm.GetInnerObj(), x));
}

static double CAlglib::LRRMSError(CLinearModelShell &lm, CMatrixDouble &xy,
                                  const int npoints) {

  return (CLinReg::LRRMSError(lm.GetInnerObj(), xy, npoints));
}

static double CAlglib::LRAvgError(CLinearModelShell &lm, CMatrixDouble &xy,
                                  const int npoints) {

  return (CLinReg::LRAvgError(lm.GetInnerObj(), xy, npoints));
}

static double CAlglib::LRAvgRelError(CLinearModelShell &lm, CMatrixDouble &xy,
                                     const int npoints) {

  return (CLinReg::LRAvgRelError(lm.GetInnerObj(), xy, npoints));
}

static void CAlglib::MLPSerialize(CMultilayerPerceptronShell &obj,
                                  string &s_out) {

  CSerializer s;

  s.Alloc_Start();

  CMLPBase::MLPAlloc(s, obj.GetInnerObj());

  s.SStart_Str();

  CMLPBase::MLPSerialize(s, obj.GetInnerObj());

  s.Stop();

  s_out = s.Get_String();
}

static void CAlglib::MLPUnserialize(const string s_in,
                                    CMultilayerPerceptronShell &obj) {

  CSerializer s;

  s.UStart_Str(s_in);

  CMLPBase::MLPUnserialize(s, obj.GetInnerObj());

  s.Stop();
}

static void CAlglib::MLPCreate0(const int nin, const int nout,
                                CMultilayerPerceptronShell &network) {

  CMLPBase::MLPCreate0(nin, nout, network.GetInnerObj());

  return;
}

static void CAlglib::MLPCreate1(const int nin, int nhid, const int nout,
                                CMultilayerPerceptronShell &network) {

  CMLPBase::MLPCreate1(nin, nhid, nout, network.GetInnerObj());

  return;
}

static void CAlglib::MLPCreate2(const int nin, const int nhid1, const int nhid2,
                                const int nout,
                                CMultilayerPerceptronShell &network) {

  CMLPBase::MLPCreate2(nin, nhid1, nhid2, nout, network.GetInnerObj());

  return;
}

static void CAlglib::MLPCreateB0(const int nin, const int nout, const double b,
                                 const double d,
                                 CMultilayerPerceptronShell &network) {

  CMLPBase::MLPCreateB0(nin, nout, b, d, network.GetInnerObj());

  return;
}

static void CAlglib::MLPCreateB1(const int nin, int nhid, const int nout,
                                 const double b, const double d,
                                 CMultilayerPerceptronShell &network) {

  CMLPBase::MLPCreateB1(nin, nhid, nout, b, d, network.GetInnerObj());

  return;
}

static void CAlglib::MLPCreateB2(const int nin, const int nhid1,
                                 const int nhid2, const int nout,
                                 const double b, const double d,
                                 CMultilayerPerceptronShell &network) {

  CMLPBase::MLPCreateB2(nin, nhid1, nhid2, nout, b, d, network.GetInnerObj());

  return;
}

static void CAlglib::MLPCreateR0(const int nin, const int nout, double a,
                                 const double b,
                                 CMultilayerPerceptronShell &network) {

  CMLPBase::MLPCreateR0(nin, nout, a, b, network.GetInnerObj());

  return;
}

static void CAlglib::MLPCreateR1(const int nin, int nhid, const int nout,
                                 const double a, const double b,
                                 CMultilayerPerceptronShell &network) {

  CMLPBase::MLPCreateR1(nin, nhid, nout, a, b, network.GetInnerObj());

  return;
}

static void CAlglib::MLPCreateR2(const int nin, const int nhid1,
                                 const int nhid2, const int nout,
                                 const double a, const double b,
                                 CMultilayerPerceptronShell &network) {

  CMLPBase::MLPCreateR2(nin, nhid1, nhid2, nout, a, b, network.GetInnerObj());

  return;
}

static void CAlglib::MLPCreateC0(const int nin, const int nout,
                                 CMultilayerPerceptronShell &network) {

  CMLPBase::MLPCreateC0(nin, nout, network.GetInnerObj());

  return;
}

static void CAlglib::MLPCreateC1(const int nin, int nhid, const int nout,
                                 CMultilayerPerceptronShell &network) {

  CMLPBase::MLPCreateC1(nin, nhid, nout, network.GetInnerObj());

  return;
}

static void CAlglib::MLPCreateC2(const int nin, const int nhid1,
                                 const int nhid2, const int nout,
                                 CMultilayerPerceptronShell &network) {

  CMLPBase::MLPCreateC2(nin, nhid1, nhid2, nout, network.GetInnerObj());

  return;
}

static void CAlglib::MLPRandomize(CMultilayerPerceptronShell &network) {

  CMLPBase::MLPRandomize(network.GetInnerObj());

  return;
}

static void CAlglib::MLPRandomizeFull(CMultilayerPerceptronShell &network) {

  CMLPBase::MLPRandomizeFull(network.GetInnerObj());

  return;
}

static void CAlglib::MLPProperties(CMultilayerPerceptronShell &network,
                                   int &nin, int &nout, int &wcount) {

  nin = 0;
  nout = 0;
  wcount = 0;

  CMLPBase::MLPProperties(network.GetInnerObj(), nin, nout, wcount);

  return;
}

static bool CAlglib::MLPIsSoftMax(CMultilayerPerceptronShell &network) {

  return (CMLPBase::MLPIsSoftMax(network.GetInnerObj()));
}

static int CAlglib::MLPGetLayersCount(CMultilayerPerceptronShell &network) {

  return (CMLPBase::MLPGetLayersCount(network.GetInnerObj()));
}

static int CAlglib::MLPGetLayerSize(CMultilayerPerceptronShell &network,
                                    const int k) {

  return (CMLPBase::MLPGetLayerSize(network.GetInnerObj(), k));
}

static void CAlglib::MLPGetInputScaling(CMultilayerPerceptronShell &network,
                                        const int i, double &mean,
                                        double &sigma) {

  mean = 0;
  sigma = 0;

  CMLPBase::MLPGetInputScaling(network.GetInnerObj(), i, mean, sigma);

  return;
}

static void CAlglib::MLPGetOutputScaling(CMultilayerPerceptronShell &network,
                                         const int i, double &mean,
                                         double &sigma) {

  mean = 0;
  sigma = 0;

  CMLPBase::MLPGetOutputScaling(network.GetInnerObj(), i, mean, sigma);

  return;
}

static void CAlglib::MLPGetNeuronInfo(CMultilayerPerceptronShell &network,
                                      const int k, const int i, int &fkind,
                                      double &threshold) {

  fkind = 0;
  threshold = 0;

  CMLPBase::MLPGetNeuronInfo(network.GetInnerObj(), k, i, fkind, threshold);

  return;
}

static double CAlglib::MLPGetWeight(CMultilayerPerceptronShell &network,
                                    const int k0, const int i0, const int k1,
                                    const int i1) {

  return (CMLPBase::MLPGetWeight(network.GetInnerObj(), k0, i0, k1, i1));
}

static void CAlglib::MLPSetInputScaling(CMultilayerPerceptronShell &network,
                                        const int i, const double mean,
                                        const double sigma) {

  CMLPBase::MLPSetInputScaling(network.GetInnerObj(), i, mean, sigma);

  return;
}

static void CAlglib::MLPSetOutputScaling(CMultilayerPerceptronShell &network,
                                         const int i, const double mean,
                                         const double sigma) {

  CMLPBase::MLPSetOutputScaling(network.GetInnerObj(), i, mean, sigma);

  return;
}

static void CAlglib::MLPSetNeuronInfo(CMultilayerPerceptronShell &network,
                                      const int k, const int i, int fkind,
                                      double threshold) {

  CMLPBase::MLPSetNeuronInfo(network.GetInnerObj(), k, i, fkind, threshold);

  return;
}

static void CAlglib::MLPSetWeight(CMultilayerPerceptronShell &network,
                                  const int k0, const int i0, const int k1,
                                  const int i1, const double w) {

  CMLPBase::MLPSetWeight(network.GetInnerObj(), k0, i0, k1, i1, w);

  return;
}

static void CAlglib::MLPActivationFunction(const double net, const int k,
                                           double &f, double &df, double &d2f) {

  f = 0;
  df = 0;
  d2f = 0;

  CMLPBase::MLPActivationFunction(net, k, f, df, d2f);

  return;
}

static void CAlglib::MLPProcess(CMultilayerPerceptronShell &network,
                                double &x[], double &y[]) {

  CMLPBase::MLPProcess(network.GetInnerObj(), x, y);

  return;
}

static void CAlglib::MLPProcessI(CMultilayerPerceptronShell &network,
                                 double &x[], double &y[]) {

  CMLPBase::MLPProcessI(network.GetInnerObj(), x, y);

  return;
}

static double CAlglib::MLPError(CMultilayerPerceptronShell &network,
                                CMatrixDouble &xy, const int ssize) {

  return (CMLPBase::MLPError(network.GetInnerObj(), xy, ssize));
}

static double CAlglib::MLPErrorN(CMultilayerPerceptronShell &network,
                                 CMatrixDouble &xy, const int ssize) {

  return (CMLPBase::MLPErrorN(network.GetInnerObj(), xy, ssize));
}

static int CAlglib::MLPClsError(CMultilayerPerceptronShell &network,
                                CMatrixDouble &xy, const int ssize) {

  return (CMLPBase::MLPClsError(network.GetInnerObj(), xy, ssize));
}

static double CAlglib::MLPRelClsError(CMultilayerPerceptronShell &network,
                                      CMatrixDouble &xy, const int npoints) {

  return (CMLPBase::MLPRelClsError(network.GetInnerObj(), xy, npoints));
}

static double CAlglib::MLPAvgCE(CMultilayerPerceptronShell &network,
                                CMatrixDouble &xy, const int npoints) {

  return (CMLPBase::MLPAvgCE(network.GetInnerObj(), xy, npoints));
}

static double CAlglib::MLPRMSError(CMultilayerPerceptronShell &network,
                                   CMatrixDouble &xy, const int npoints) {

  return (CMLPBase::MLPRMSError(network.GetInnerObj(), xy, npoints));
}

static double CAlglib::MLPAvgError(CMultilayerPerceptronShell &network,
                                   CMatrixDouble &xy, const int npoints) {

  return (CMLPBase::MLPAvgError(network.GetInnerObj(), xy, npoints));
}

static double CAlglib::MLPAvgRelError(CMultilayerPerceptronShell &network,
                                      CMatrixDouble &xy, const int npoints) {

  return (CMLPBase::MLPAvgRelError(network.GetInnerObj(), xy, npoints));
}

static void CAlglib::MLPGrad(CMultilayerPerceptronShell &network, double &x[],
                             double &desiredy[], double &e, double &grad[]) {

  e = 0;

  CMLPBase::MLPGrad(network.GetInnerObj(), x, desiredy, e, grad);

  return;
}

static void CAlglib::MLPGradN(CMultilayerPerceptronShell &network, double &x[],
                              double &desiredy[], double &e, double &grad[]) {

  e = 0;

  CMLPBase::MLPGradN(network.GetInnerObj(), x, desiredy, e, grad);

  return;
}

static void CAlglib::MLPGradBatch(CMultilayerPerceptronShell &network,
                                  CMatrixDouble &xy, const int ssize, double &e,
                                  double &grad[]) {

  e = 0;

  CMLPBase::MLPGradBatch(network.GetInnerObj(), xy, ssize, e, grad);

  return;
}

static void CAlglib::MLPGradNBatch(CMultilayerPerceptronShell &network,
                                   CMatrixDouble &xy, const int ssize,
                                   double &e, double &grad[]) {

  e = 0;

  CMLPBase::MLPGradNBatch(network.GetInnerObj(), xy, ssize, e, grad);

  return;
}

static void CAlglib::MLPHessianNBatch(CMultilayerPerceptronShell &network,
                                      CMatrixDouble &xy, const int ssize,
                                      double &e, double &grad[],
                                      CMatrixDouble &h) {

  e = 0;

  CMLPBase::MLPHessianNBatch(network.GetInnerObj(), xy, ssize, e, grad, h);

  return;
}

static void CAlglib::MLPHessianBatch(CMultilayerPerceptronShell &network,
                                     CMatrixDouble &xy, const int ssize,
                                     double &e, double &grad[],
                                     CMatrixDouble &h) {

  e = 0;

  CMLPBase::MLPHessianBatch(network.GetInnerObj(), xy, ssize, e, grad, h);

  return;
}

static void CAlglib::MNLTrainH(CMatrixDouble &xy, const int npoints,
                               const int nvars, const int nclasses, int &info,
                               CLogitModelShell &lm, CMNLReportShell &rep) {

  info = 0;

  CLogit::MNLTrainH(xy, npoints, nvars, nclasses, info, lm.GetInnerObj(),
                    rep.GetInnerObj());

  return;
}

static void CAlglib::MNLProcess(CLogitModelShell &lm, double &x[],
                                double &y[]) {

  CLogit::MNLProcess(lm.GetInnerObj(), x, y);

  return;
}

static void CAlglib::MNLProcessI(CLogitModelShell &lm, double &x[],
                                 double &y[]) {

  CLogit::MNLProcessI(lm.GetInnerObj(), x, y);

  return;
}

static void CAlglib::MNLUnpack(CLogitModelShell &lm, CMatrixDouble &a,
                               int &nvars, int &nclasses) {

  nvars = 0;
  nclasses = 0;

  CLogit::MNLUnpack(lm.GetInnerObj(), a, nvars, nclasses);

  return;
}

static void CAlglib::MNLPack(CMatrixDouble &a, const int nvars,
                             const int nclasses, CLogitModelShell &lm) {

  CLogit::MNLPack(a, nvars, nclasses, lm.GetInnerObj());

  return;
}

static double CAlglib::MNLAvgCE(CLogitModelShell &lm, CMatrixDouble &xy,
                                const int npoints) {

  return (CLogit::MNLAvgCE(lm.GetInnerObj(), xy, npoints));
}

static double CAlglib::MNLRelClsError(CLogitModelShell &lm, CMatrixDouble &xy,
                                      const int npoints) {

  return (CLogit::MNLRelClsError(lm.GetInnerObj(), xy, npoints));
}

static double CAlglib::MNLRMSError(CLogitModelShell &lm, CMatrixDouble &xy,
                                   const int npoints) {

  return (CLogit::MNLRMSError(lm.GetInnerObj(), xy, npoints));
}

static double CAlglib::MNLAvgError(CLogitModelShell &lm, CMatrixDouble &xy,
                                   const int npoints) {

  return (CLogit::MNLAvgError(lm.GetInnerObj(), xy, npoints));
}

static double CAlglib::MNLAvgRelError(CLogitModelShell &lm, CMatrixDouble &xy,
                                      const int ssize) {

  return (CLogit::MNLAvgRelError(lm.GetInnerObj(), xy, ssize));
}

static int CAlglib::MNLClsError(CLogitModelShell &lm, CMatrixDouble &xy,
                                const int npoints) {

  return (CLogit::MNLClsError(lm.GetInnerObj(), xy, npoints));
}

static void CAlglib::MCPDCreate(const int n, CMCPDStateShell &s) {

  CMarkovCPD::MCPDCreate(n, s.GetInnerObj());

  return;
}

static void CAlglib::MCPDCreateEntry(const int n, const int entrystate,
                                     CMCPDStateShell &s) {

  CMarkovCPD::MCPDCreateEntry(n, entrystate, s.GetInnerObj());

  return;
}

static void CAlglib::MCPDCreateExit(const int n, const int exitstate,
                                    CMCPDStateShell &s) {

  CMarkovCPD::MCPDCreateExit(n, exitstate, s.GetInnerObj());

  return;
}

static void CAlglib::MCPDCreateEntryExit(const int n, const int entrystate,
                                         const int exitstate,
                                         CMCPDStateShell &s) {

  CMarkovCPD::MCPDCreateEntryExit(n, entrystate, exitstate, s.GetInnerObj());

  return;
}

static void CAlglib::MCPDAddTrack(CMCPDStateShell &s, CMatrixDouble &xy,
                                  const int k) {

  CMarkovCPD::MCPDAddTrack(s.GetInnerObj(), xy, k);

  return;
}

static void CAlglib::MCPDAddTrack(CMCPDStateShell &s, CMatrixDouble &xy) {

  int k;

  k = CAp::Rows(xy);

  CMarkovCPD::MCPDAddTrack(s.GetInnerObj(), xy, k);

  return;
}

static void CAlglib::MCPDSetEC(CMCPDStateShell &s, CMatrixDouble &ec) {

  CMarkovCPD::MCPDSetEC(s.GetInnerObj(), ec);

  return;
}

static void CAlglib::MCPDAddEC(CMCPDStateShell &s, const int i, const int j,
                               const double c) {

  CMarkovCPD::MCPDAddEC(s.GetInnerObj(), i, j, c);

  return;
}

static void CAlglib::MCPDSetBC(CMCPDStateShell &s, CMatrixDouble &bndl,
                               CMatrixDouble &bndu) {

  CMarkovCPD::MCPDSetBC(s.GetInnerObj(), bndl, bndu);

  return;
}

static void CAlglib::MCPDAddBC(CMCPDStateShell &s, const int i, const int j,
                               const double bndl, const double bndu) {

  CMarkovCPD::MCPDAddBC(s.GetInnerObj(), i, j, bndl, bndu);

  return;
}

static void CAlglib::MCPDSetLC(CMCPDStateShell &s, CMatrixDouble &c, int &ct[],
                               const int k) {

  CMarkovCPD::MCPDSetLC(s.GetInnerObj(), c, ct, k);

  return;
}

static void CAlglib::MCPDSetLC(CMCPDStateShell &s, CMatrixDouble &c,
                               int &ct[]) {

  int k;

  if ((CAp::Rows(c) != CAp::Len(ct))) {
    Print("Error while calling " + __FUNCTION__ +
          ": looks like one of arguments has wrong size");
    CAp::exception_happened = true;
    return;
  }

  k = CAp::Rows(c);

  CMarkovCPD::MCPDSetLC(s.GetInnerObj(), c, ct, k);

  return;
}

static void CAlglib::MCPDSetTikhonovRegularizer(CMCPDStateShell &s,
                                                const double v) {

  CMarkovCPD::MCPDSetTikhonovRegularizer(s.GetInnerObj(), v);

  return;
}

static void CAlglib::MCPDSetPrior(CMCPDStateShell &s, CMatrixDouble &pp) {

  CMarkovCPD::MCPDSetPrior(s.GetInnerObj(), pp);

  return;
}

static void CAlglib::MCPDSetPredictionWeights(CMCPDStateShell &s,
                                              double &pw[]) {

  CMarkovCPD::MCPDSetPredictionWeights(s.GetInnerObj(), pw);

  return;
}

static void CAlglib::MCPDSolve(CMCPDStateShell &s) {

  CMarkovCPD::MCPDSolve(s.GetInnerObj());

  return;
}

static void CAlglib::MCPDResults(CMCPDStateShell &s, CMatrixDouble &p,
                                 CMCPDReportShell &rep) {

  CMarkovCPD::MCPDResults(s.GetInnerObj(), p, rep.GetInnerObj());

  return;
}

static void CAlglib::MLPTrainLM(CMultilayerPerceptronShell &network,
                                CMatrixDouble &xy, const int npoints,
                                const double decay, const int restarts,
                                int &info, CMLPReportShell &rep) {

  info = 0;

  CMLPTrain::MLPTrainLM(network.GetInnerObj(), xy, npoints, decay, restarts,
                        info, rep.GetInnerObj());

  return;
}

static void CAlglib::MLPTrainLBFGS(CMultilayerPerceptronShell &network,
                                   CMatrixDouble &xy, const int npoints,
                                   const double decay, const int restarts,
                                   const double wstep, int maxits, int &info,
                                   CMLPReportShell &rep) {

  info = 0;

  CMLPTrain::MLPTrainLBFGS(network.GetInnerObj(), xy, npoints, decay, restarts,
                           wstep, maxits, info, rep.GetInnerObj());

  return;
}

static void CAlglib::MLPTrainES(CMultilayerPerceptronShell &network,
                                CMatrixDouble &trnxy, const int trnsize,
                                CMatrixDouble &valxy, const int valsize,
                                const double decay, const int restarts,
                                int &info, CMLPReportShell &rep) {

  info = 0;

  CMLPTrain::MLPTrainES(network.GetInnerObj(), trnxy, trnsize, valxy, valsize,
                        decay, restarts, info, rep.GetInnerObj());

  return;
}

static void CAlglib::MLPKFoldCVLBFGS(CMultilayerPerceptronShell &network,
                                     CMatrixDouble &xy, const int npoints,
                                     const double decay, const int restarts,
                                     const double wstep, const int maxits,
                                     const int foldscount, int &info,
                                     CMLPReportShell &rep,
                                     CMLPCVReportShell &cvrep) {

  info = 0;

  CMLPTrain::MLPKFoldCVLBFGS(network.GetInnerObj(), xy, npoints, decay,
                             restarts, wstep, maxits, foldscount, info,
                             rep.GetInnerObj(), cvrep.GetInnerObj());

  return;
}

static void CAlglib::MLPKFoldCVLM(CMultilayerPerceptronShell &network,
                                  CMatrixDouble &xy, const int npoints,
                                  const double decay, const int restarts,
                                  const int foldscount, int &info,
                                  CMLPReportShell &rep,
                                  CMLPCVReportShell &cvrep) {

  info = 0;

  CMLPTrain::MLPKFoldCVLM(network.GetInnerObj(), xy, npoints, decay, restarts,
                          foldscount, info, rep.GetInnerObj(),
                          cvrep.GetInnerObj());

  return;
}

static void CAlglib::MLPECreate0(const int nin, const int nout,
                                 const int ensemblesize,
                                 CMLPEnsembleShell &ensemble) {

  CMLPE::MLPECreate0(nin, nout, ensemblesize, ensemble.GetInnerObj());

  return;
}

static void CAlglib::MLPECreate1(const int nin, int nhid, const int nout,
                                 const int ensemblesize,
                                 CMLPEnsembleShell &ensemble) {

  CMLPE::MLPECreate1(nin, nhid, nout, ensemblesize, ensemble.GetInnerObj());

  return;
}

static void CAlglib::MLPECreate2(const int nin, const int nhid1,
                                 const int nhid2, const int nout,
                                 const int ensemblesize,
                                 CMLPEnsembleShell &ensemble) {

  CMLPE::MLPECreate2(nin, nhid1, nhid2, nout, ensemblesize,
                     ensemble.GetInnerObj());

  return;
}

static void CAlglib::MLPECreateB0(const int nin, const int nout, const double b,
                                  const double d, const int ensemblesize,
                                  CMLPEnsembleShell &ensemble) {

  CMLPE::MLPECreateB0(nin, nout, b, d, ensemblesize, ensemble.GetInnerObj());

  return;
}

static void CAlglib::MLPECreateB1(const int nin, int nhid, const int nout,
                                  const double b, const double d,
                                  const int ensemblesize,
                                  CMLPEnsembleShell &ensemble) {

  CMLPE::MLPECreateB1(nin, nhid, nout, b, d, ensemblesize,
                      ensemble.GetInnerObj());

  return;
}

static void CAlglib::MLPECreateB2(const int nin, const int nhid1,
                                  const int nhid2, const int nout,
                                  const double b, const double d,
                                  const int ensemblesize,
                                  CMLPEnsembleShell &ensemble) {

  CMLPE::MLPECreateB2(nin, nhid1, nhid2, nout, b, d, ensemblesize,
                      ensemble.GetInnerObj());

  return;
}

static void CAlglib::MLPECreateR0(const int nin, const int nout, const double a,
                                  const double b, const int ensemblesize,
                                  CMLPEnsembleShell &ensemble) {

  CMLPE::MLPECreateR0(nin, nout, a, b, ensemblesize, ensemble.GetInnerObj());

  return;
}

static void CAlglib::MLPECreateR1(const int nin, int nhid, const int nout,
                                  const double a, const double b,
                                  const int ensemblesize,
                                  CMLPEnsembleShell &ensemble) {

  CMLPE::MLPECreateR1(nin, nhid, nout, a, b, ensemblesize,
                      ensemble.GetInnerObj());

  return;
}

static void CAlglib::MLPECreateR2(const int nin, const int nhid1,
                                  const int nhid2, const int nout,
                                  const double a, const double b,
                                  const int ensemblesize,
                                  CMLPEnsembleShell &ensemble) {

  CMLPE::MLPECreateR2(nin, nhid1, nhid2, nout, a, b, ensemblesize,
                      ensemble.GetInnerObj());

  return;
}

static void CAlglib::MLPECreateC0(const int nin, const int nout,
                                  const int ensemblesize,
                                  CMLPEnsembleShell &ensemble) {

  CMLPE::MLPECreateC0(nin, nout, ensemblesize, ensemble.GetInnerObj());

  return;
}

static void CAlglib::MLPECreateC1(const int nin, int nhid, const int nout,
                                  const int ensemblesize,
                                  CMLPEnsembleShell &ensemble) {

  CMLPE::MLPECreateC1(nin, nhid, nout, ensemblesize, ensemble.GetInnerObj());

  return;
}

static void CAlglib::MLPECreateC2(const int nin, const int nhid1,
                                  const int nhid2, const int nout,
                                  const int ensemblesize,
                                  CMLPEnsembleShell &ensemble) {

  CMLPE::MLPECreateC2(nin, nhid1, nhid2, nout, ensemblesize,
                      ensemble.GetInnerObj());

  return;
}

static void CAlglib::MLPECreateFromNetwork(CMultilayerPerceptronShell &network,
                                           const int ensemblesize,
                                           CMLPEnsembleShell &ensemble) {

  CMLPE::MLPECreateFromNetwork(network.GetInnerObj(), ensemblesize,
                               ensemble.GetInnerObj());

  return;
}

static void CAlglib::MLPERandomize(CMLPEnsembleShell &ensemble) {

  CMLPE::MLPERandomize(ensemble.GetInnerObj());

  return;
}

static void CAlglib::MLPEProperties(CMLPEnsembleShell &ensemble, int &nin,
                                    int &nout) {

  nin = 0;
  nout = 0;

  CMLPE::MLPEProperties(ensemble.GetInnerObj(), nin, nout);

  return;
}

static bool CAlglib::MLPEIsSoftMax(CMLPEnsembleShell &ensemble) {

  return (CMLPE::MLPEIsSoftMax(ensemble.GetInnerObj()));
}

static void CAlglib::MLPEProcess(CMLPEnsembleShell &ensemble, double &x[],
                                 double &y[]) {

  CMLPE::MLPEProcess(ensemble.GetInnerObj(), x, y);

  return;
}

static void CAlglib::MLPEProcessI(CMLPEnsembleShell &ensemble, double &x[],
                                  double &y[]) {

  CMLPE::MLPEProcessI(ensemble.GetInnerObj(), x, y);

  return;
}

static double CAlglib::MLPERelClsError(CMLPEnsembleShell &ensemble,
                                       CMatrixDouble &xy, const int npoints) {

  return (CMLPE::MLPERelClsError(ensemble.GetInnerObj(), xy, npoints));
}

static double CAlglib::MLPEAvgCE(CMLPEnsembleShell &ensemble, CMatrixDouble &xy,
                                 const int npoints) {

  return (CMLPE::MLPEAvgCE(ensemble.GetInnerObj(), xy, npoints));
}

static double CAlglib::MLPERMSError(CMLPEnsembleShell &ensemble,
                                    CMatrixDouble &xy, const int npoints) {

  return (CMLPE::MLPERMSError(ensemble.GetInnerObj(), xy, npoints));
}

static double CAlglib::MLPEAvgError(CMLPEnsembleShell &ensemble,
                                    CMatrixDouble &xy, const int npoints) {

  return (CMLPE::MLPEAvgError(ensemble.GetInnerObj(), xy, npoints));
}

static double CAlglib::MLPEAvgRelError(CMLPEnsembleShell &ensemble,
                                       CMatrixDouble &xy, const int npoints) {

  return (CMLPE::MLPEAvgRelError(ensemble.GetInnerObj(), xy, npoints));
}

static void CAlglib::MLPEBaggingLM(CMLPEnsembleShell &ensemble,
                                   CMatrixDouble &xy, const int npoints,
                                   const double decay, const int restarts,
                                   int &info, CMLPReportShell &rep,
                                   CMLPCVReportShell &ooberrors) {

  info = 0;

  CMLPE::MLPEBaggingLM(ensemble.GetInnerObj(), xy, npoints, decay, restarts,
                       info, rep.GetInnerObj(), ooberrors.GetInnerObj());

  return;
}

static void CAlglib::MLPEBaggingLBFGS(CMLPEnsembleShell &ensemble,
                                      CMatrixDouble &xy, const int npoints,
                                      const double decay, const int restarts,
                                      const double wstep, const int maxits,
                                      int &info, CMLPReportShell &rep,
                                      CMLPCVReportShell &ooberrors) {

  info = 0;

  CMLPE::MLPEBaggingLBFGS(ensemble.GetInnerObj(), xy, npoints, decay, restarts,
                          wstep, maxits, info, rep.GetInnerObj(),
                          ooberrors.GetInnerObj());

  return;
}

static void CAlglib::MLPETrainES(CMLPEnsembleShell &ensemble, CMatrixDouble &xy,
                                 const int npoints, const double decay,
                                 const int restarts, int &info,
                                 CMLPReportShell &rep) {

  info = 0;

  CMLPE::MLPETrainES(ensemble.GetInnerObj(), xy, npoints, decay, restarts, info,
                     rep.GetInnerObj());

  return;
}

static void CAlglib::PCABuildBasis(CMatrixDouble &x, const int npoints,
                                   const int nvars, int &info, double &s2[],
                                   CMatrixDouble &v) {

  info = 0;

  CPCAnalysis::PCABuildBasis(x, npoints, nvars, info, s2, v);

  return;
}

static void CAlglib::ODESolverRKCK(double &y[], const int n, double &x[],
                                   const int m, const double eps,
                                   const double h,
                                   CODESolverStateShell &state) {

  CODESolver::ODESolverRKCK(y, n, x, m, eps, h, state.GetInnerObj());

  return;
}

static void CAlglib::ODESolverRKCK(double &y[], double &x[], const double eps,
                                   const double h,
                                   CODESolverStateShell &state) {

  int n;
  int m;

  n = CAp::Len(y);
  m = CAp::Len(x);

  CODESolver::ODESolverRKCK(y, n, x, m, eps, h, state.GetInnerObj());

  return;
}

static bool CAlglib::ODESolverIteration(CODESolverStateShell &state) {

  return (CODESolver::ODESolverIteration(state.GetInnerObj()));
}

static void CAlglib::ODESolverSolve(CODESolverStateShell &state,
                                    CNDimensional_ODE_RP &diff, CObject &obj) {

  while (CAlglib::ODESolverIteration(state)) {

    if (state.GetNeedDY()) {
      diff.ODE_RP(state.GetInnerObj().m_y, state.GetInnerObj().m_x,
                  state.GetInnerObj().m_dy, obj);

      continue;
    }
    Print("ALGLIB: unexpected error in 'odesolversolve'");
    CAp::exception_happened = true;
    return;
  }
}

static void CAlglib::ODESolverResults(CODESolverStateShell &state, int &m,
                                      double &xtbl[], CMatrixDouble &ytbl,
                                      CODESolverReportShell &rep) {

  m = 0;

  CODESolver::ODESolverResults(state.GetInnerObj(), m, xtbl, ytbl,
                               rep.GetInnerObj());

  return;
}

static void CAlglib::FFTC1D(al_complex &a[], const int n) {

  CFastFourierTransform::FFTC1D(a, n);

  return;
}

static void CAlglib::FFTC1D(al_complex &a[]) {

  int n;

  n = CAp::Len(a);

  CFastFourierTransform::FFTC1D(a, n);

  return;
}

static void CAlglib::FFTC1DInv(al_complex &a[], const int n) {

  CFastFourierTransform::FFTC1DInv(a, n);

  return;
}

static void CAlglib::FFTC1DInv(al_complex &a[]) {

  int n;

  n = CAp::Len(a);

  CFastFourierTransform::FFTC1DInv(a, n);

  return;
}

static void CAlglib::FFTR1D(double &a[], const int n, al_complex &f[]) {

  CFastFourierTransform::FFTR1D(a, n, f);

  return;
}

static void CAlglib::FFTR1D(double &a[], al_complex &f[]) {

  int n;

  n = CAp::Len(a);

  CFastFourierTransform::FFTR1D(a, n, f);

  return;
}

static void CAlglib::FFTR1DInv(al_complex &f[], const int n, double &a[]) {

  CFastFourierTransform::FFTR1DInv(f, n, a);

  return;
}

static void CAlglib::FFTR1DInv(al_complex &f[], double &a[]) {

  int n;

  n = CAp::Len(f);

  CFastFourierTransform::FFTR1DInv(f, n, a);

  return;
}

static void CAlglib::ConvC1D(al_complex &a[], const int m, al_complex &b[],
                             const int n, al_complex &r[]) {

  CConv::ConvC1D(a, m, b, n, r);

  return;
}

static void CAlglib::ConvC1DInv(al_complex &a[], const int m, al_complex &b[],
                                const int n, al_complex &r[]) {

  CConv::ConvC1DInv(a, m, b, n, r);

  return;
}

static void CAlglib::ConvC1DCircular(al_complex &s[], const int m,
                                     al_complex &r[], const int n,
                                     al_complex &c[]) {

  CConv::ConvC1DCircular(s, m, r, n, c);

  return;
}

static void CAlglib::ConvC1DCircularInv(al_complex &a[], const int m,
                                        al_complex &b[], const int n,
                                        al_complex &r[]) {

  CConv::ConvC1DCircularInv(a, m, b, n, r);

  return;
}

static void CAlglib::ConvR1D(double &a[], const int m, double &b[], const int n,
                             double &r[]) {

  CConv::ConvR1D(a, m, b, n, r);

  return;
}

static void CAlglib::ConvR1DInv(double &a[], const int m, double &b[],
                                const int n, double &r[]) {

  CConv::ConvR1DInv(a, m, b, n, r);

  return;
}

static void CAlglib::ConvR1DCircular(double &s[], const int m, double &r[],
                                     const int n, double &c[]) {

  CConv::ConvR1DCircular(s, m, r, n, c);

  return;
}

static void CAlglib::ConvR1DCircularInv(double &a[], const int m, double &b[],
                                        const int n, double &r[]) {

  CConv::ConvR1DCircularInv(a, m, b, n, r);

  return;
}

static void CAlglib::CorrC1D(al_complex &signal[], const int n,
                             al_complex &pattern[], const int m,
                             al_complex &r[]) {

  CCorr::CorrC1D(signal, n, pattern, m, r);

  return;
}

static void CAlglib::CorrC1DCircular(al_complex &signal[], const int m,
                                     al_complex &pattern[], const int n,
                                     al_complex &c[]) {

  CCorr::CorrC1DCircular(signal, m, pattern, n, c);

  return;
}

static void CAlglib::CorrR1D(double &signal[], const int n, double &pattern[],
                             const int m, double &r[]) {

  CCorr::CorrR1D(signal, n, pattern, m, r);

  return;
}

static void CAlglib::CorrR1DCircular(double &signal[], const int m,
                                     double &pattern[], const int n,
                                     double &c[]) {

  CCorr::CorrR1DCircular(signal, m, pattern, n, c);

  return;
}

static void CAlglib::FHTR1D(double &a[], const int n) {

  CFastHartleyTransform::FHTR1D(a, n);

  return;
}

static void CAlglib::FHTR1DInv(double &a[], const int n) {

  CFastHartleyTransform::FHTR1DInv(a, n);

  return;
}

static void CAlglib::GQGenerateRec(double &alpha[], double &beta[],
                                   const double mu0, const int n, int &info,
                                   double &x[], double &w[]) {

  info = 0;

  CGaussQ::GQGenerateRec(alpha, beta, mu0, n, info, x, w);

  return;
}

static void CAlglib::GQGenerateGaussLobattoRec(double &alpha[], double &beta[],
                                               const double mu0, const double a,
                                               const double b, const int n,
                                               int &info, double &x[],
                                               double &w[]) {

  info = 0;

  CGaussQ::GQGenerateGaussLobattoRec(alpha, beta, mu0, a, b, n, info, x, w);

  return;
}

static void CAlglib::GQGenerateGaussRadauRec(double &alpha[], double &beta[],
                                             const double mu0, const double a,
                                             const int n, int &info,
                                             double &x[], double &w[]) {

  info = 0;

  CGaussQ::GQGenerateGaussRadauRec(alpha, beta, mu0, a, n, info, x, w);

  return;
}

static void CAlglib::GQGenerateGaussLegendre(const int n, int &info,
                                             double &x[], double &w[]) {

  info = 0;

  CGaussQ::GQGenerateGaussLegendre(n, info, x, w);

  return;
}

static void CAlglib::GQGenerateGaussJacobi(const int n, const double alpha,
                                           const double beta, int &info,
                                           double &x[], double &w[]) {

  info = 0;

  CGaussQ::GQGenerateGaussJacobi(n, alpha, beta, info, x, w);

  return;
}

static void CAlglib::GQGenerateGaussLaguerre(const int n, const double alpha,
                                             int &info, double &x[],
                                             double &w[]) {

  info = 0;

  CGaussQ::GQGenerateGaussLaguerre(n, alpha, info, x, w);

  return;
}

static void CAlglib::GQGenerateGaussHermite(const int n, int &info, double &x[],
                                            double &w[]) {

  info = 0;

  CGaussQ::GQGenerateGaussHermite(n, info, x, w);

  return;
}

static void CAlglib::GKQGenerateRec(double &alpha[], double &beta[],
                                    const double mu0, const int n, int &info,
                                    double &x[], double &wkronrod[],
                                    double &wgauss[]) {

  info = 0;

  CGaussKronrodQ::GKQGenerateRec(alpha, beta, mu0, n, info, x, wkronrod,
                                 wgauss);

  return;
}

static void CAlglib::GKQGenerateGaussLegendre(const int n, int &info,
                                              double &x[], double &wkronrod[],
                                              double &wgauss[]) {

  info = 0;

  CGaussKronrodQ::GKQGenerateGaussLegendre(n, info, x, wkronrod, wgauss);

  return;
}

static void CAlglib::GKQGenerateGaussJacobi(const int n, const double alpha,
                                            const double beta, int &info,
                                            double &x[], double &wkronrod[],
                                            double &wgauss[]) {

  info = 0;

  CGaussKronrodQ::GKQGenerateGaussJacobi(n, alpha, beta, info, x, wkronrod,
                                         wgauss);

  return;
}

static void CAlglib::GKQLegendreCalc(const int n, int &info, double &x[],
                                     double &wkronrod[], double &wgauss[]) {

  info = 0;

  CGaussKronrodQ::GKQLegendreCalc(n, info, x, wkronrod, wgauss);

  return;
}

static void CAlglib::GKQLegendreTbl(const int n, double &x[],
                                    double &wkronrod[], double &wgauss[],
                                    double &eps) {

  eps = 0;

  CGaussKronrodQ::GKQLegendreTbl(n, x, wkronrod, wgauss, eps);

  return;
}

static void CAlglib::AutoGKSmooth(const double a, const double b,
                                  CAutoGKStateShell &state) {

  CAutoGK::AutoGKSmooth(a, b, state.GetInnerObj());

  return;
}

static void CAlglib::AutoGKSmoothW(const double a, const double b,
                                   double xwidth, CAutoGKStateShell &state) {

  CAutoGK::AutoGKSmoothW(a, b, xwidth, state.GetInnerObj());

  return;
}

static void CAlglib::AutoGKSingular(const double a, const double b,
                                    const double alpha, const double beta,
                                    CAutoGKStateShell &state) {

  CAutoGK::AutoGKSingular(a, b, alpha, beta, state.GetInnerObj());

  return;
}

static bool CAlglib::AutoGKIteration(CAutoGKStateShell &state) {

  return (CAutoGK::AutoGKIteration(state.GetInnerObj()));
}

static void CAlglib::AutoGKIntegrate(CAutoGKStateShell &state,
                                     CIntegrator1_Func &func, CObject &obj) {

  while (CAlglib::AutoGKIteration(state)) {

    if (state.GetNeedF()) {
      func.Int_Func(state.GetInnerObj().m_x, state.GetInnerObj().m_xminusa,
                    state.GetInnerObj().m_bminusx, state.GetInnerObj().m_f,
                    obj);

      continue;
    }
    Print("ALGLIB: unexpected error in 'autogksolve'");
    CAp::exception_happened = true;
    return;
  }
}

static void CAlglib::AutoGKResults(CAutoGKStateShell &state, double &v,
                                   CAutoGKReportShell &rep) {

  v = 0;

  CAutoGK::AutoGKResults(state.GetInnerObj(), v, rep.GetInnerObj());

  return;
}

static double CAlglib::IDWCalc(CIDWInterpolantShell &z, double &x[]) {

  return (CIDWInt::IDWCalc(z.GetInnerObj(), x));
}

static void CAlglib::IDWBuildModifiedShepard(CMatrixDouble &xy, const int n,
                                             const int nx, const int d,
                                             const int nq, const int nw,
                                             CIDWInterpolantShell &z) {

  CIDWInt::IDWBuildModifiedShepard(xy, n, nx, d, nq, nw, z.GetInnerObj());

  return;
}

static void CAlglib::IDWBuildModifiedShepardR(CMatrixDouble &xy, const int n,
                                              const int nx, const double r,
                                              CIDWInterpolantShell &z) {

  CIDWInt::IDWBuildModifiedShepardR(xy, n, nx, r, z.GetInnerObj());

  return;
}

static void CAlglib::IDWBuildNoisy(CMatrixDouble &xy, const int n, const int nx,
                                   const int d, const int nq, const int nw,
                                   CIDWInterpolantShell &z) {

  CIDWInt::IDWBuildNoisy(xy, n, nx, d, nq, nw, z.GetInnerObj());

  return;
}

static double CAlglib::BarycentricCalc(CBarycentricInterpolantShell &b,
                                       const double t) {

  return (CRatInt::BarycentricCalc(b.GetInnerObj(), t));
}

static void CAlglib::BarycentricDiff1(CBarycentricInterpolantShell &b,
                                      const double t, double &f, double &df) {

  f = 0;
  df = 0;

  CRatInt::BarycentricDiff1(b.GetInnerObj(), t, f, df);

  return;
}

static void CAlglib::BarycentricDiff2(CBarycentricInterpolantShell &b,
                                      const double t, double &f, double &df,
                                      double &d2f) {

  f = 0;
  df = 0;
  d2f = 0;

  CRatInt::BarycentricDiff2(b.GetInnerObj(), t, f, df, d2f);

  return;
}

static void CAlglib::BarycentricLinTransX(CBarycentricInterpolantShell &b,
                                          const double ca, const double cb) {

  CRatInt::BarycentricLinTransX(b.GetInnerObj(), ca, cb);

  return;
}

static void CAlglib::BarycentricLinTransY(CBarycentricInterpolantShell &b,
                                          const double ca, const double cb) {

  CRatInt::BarycentricLinTransY(b.GetInnerObj(), ca, cb);

  return;
}

static void CAlglib::BarycentricUnpack(CBarycentricInterpolantShell &b, int &n,
                                       double &x[], double &y[], double &w[]) {

  n = 0;

  CRatInt::BarycentricUnpack(b.GetInnerObj(), n, x, y, w);

  return;
}

static void CAlglib::BarycentricBuildXYW(double &x[], double &y[], double &w[],
                                         const int n,
                                         CBarycentricInterpolantShell &b) {

  CRatInt::BarycentricBuildXYW(x, y, w, n, b.GetInnerObj());

  return;
}

static void CAlglib::BarycentricBuildFloaterHormann(
    double &x[], double &y[], const int n, const int d,
    CBarycentricInterpolantShell &b) {

  CRatInt::BarycentricBuildFloaterHormann(x, y, n, d, b.GetInnerObj());

  return;
}

static void CAlglib::PolynomialBar2Cheb(CBarycentricInterpolantShell &p,
                                        const double a, const double b,
                                        double &t[]) {

  CPolInt::PolynomialBar2Cheb(p.GetInnerObj(), a, b, t);

  return;
}

static void CAlglib::PolynomialCheb2Bar(double &t[], const int n,
                                        const double a, const double b,
                                        CBarycentricInterpolantShell &p) {

  CPolInt::PolynomialCheb2Bar(t, n, a, b, p.GetInnerObj());

  return;
}

static void CAlglib::PolynomialCheb2Bar(double &t[], const double a,
                                        const double b,
                                        CBarycentricInterpolantShell &p) {

  int n;

  n = CAp::Len(t);

  CPolInt::PolynomialCheb2Bar(t, n, a, b, p.GetInnerObj());

  return;
}

static void CAlglib::PolynomialBar2Pow(CBarycentricInterpolantShell &p,
                                       const double c, const double s,
                                       double &a[]) {

  CPolInt::PolynomialBar2Pow(p.GetInnerObj(), c, s, a);

  return;
}

static void CAlglib::PolynomialBar2Pow(CBarycentricInterpolantShell &p,
                                       double &a[]) {

  double c;
  double s;

  c = 0;
  s = 1;

  CPolInt::PolynomialBar2Pow(p.GetInnerObj(), c, s, a);

  return;
}

static void CAlglib::PolynomialPow2Bar(double &a[], const int n, const double c,
                                       const double s,
                                       CBarycentricInterpolantShell &p) {

  CPolInt::PolynomialPow2Bar(a, n, c, s, p.GetInnerObj());

  return;
}

static void CAlglib::PolynomialPow2Bar(double &a[],
                                       CBarycentricInterpolantShell &p) {

  int n;
  double c;
  double s;

  n = CAp::Len(a);
  c = 0;
  s = 1;

  CPolInt::PolynomialPow2Bar(a, n, c, s, p.GetInnerObj());

  return;
}

static void CAlglib::PolynomialBuild(double &x[], double &y[], const int n,
                                     CBarycentricInterpolantShell &p) {

  CPolInt::PolynomialBuild(x, y, n, p.GetInnerObj());

  return;
}

static void CAlglib::PolynomialBuild(double &x[], double &y[],
                                     CBarycentricInterpolantShell &p) {

  int n;

  if ((CAp::Len(x) != CAp::Len(y))) {
    Print("Error while calling 'polynomialbuild': looks like one of arguments "
          "has wrong size");
    CAp::exception_happened = true;
    return;
  }

  n = CAp::Len(x);

  CPolInt::PolynomialBuild(x, y, n, p.GetInnerObj());

  return;
}

static void CAlglib::PolynomialBuildEqDist(const double a, const double b,
                                           double &y[], const int n,
                                           CBarycentricInterpolantShell &p) {

  CPolInt::PolynomialBuildEqDist(a, b, y, n, p.GetInnerObj());

  return;
}

static void CAlglib::PolynomialBuildEqDist(const double a, const double b,
                                           double &y[],
                                           CBarycentricInterpolantShell &p) {

  int n;

  n = CAp::Len(y);

  CPolInt::PolynomialBuildEqDist(a, b, y, n, p.GetInnerObj());

  return;
}

static void CAlglib::PolynomialBuildCheb1(const double a, const double b,
                                          double &y[], const int n,
                                          CBarycentricInterpolantShell &p) {

  CPolInt::PolynomialBuildCheb1(a, b, y, n, p.GetInnerObj());

  return;
}

static void CAlglib::PolynomialBuildCheb1(const double a, const double b,
                                          double &y[],
                                          CBarycentricInterpolantShell &p) {

  int n;

  n = CAp::Len(y);

  CPolInt::PolynomialBuildCheb1(a, b, y, n, p.GetInnerObj());

  return;
}

static void CAlglib::PolynomialBuildCheb2(const double a, const double b,
                                          double &y[], const int n,
                                          CBarycentricInterpolantShell &p) {

  CPolInt::PolynomialBuildCheb2(a, b, y, n, p.GetInnerObj());

  return;
}

static void CAlglib::PolynomialBuildCheb2(const double a, const double b,
                                          double &y[],
                                          CBarycentricInterpolantShell &p) {

  int n;

  n = CAp::Len(y);

  CPolInt::PolynomialBuildCheb2(a, b, y, n, p.GetInnerObj());

  return;
}

static double CAlglib::PolynomialCalcEqDist(const double a, const double b,
                                            double &f[], const int n,
                                            const double t) {

  return (CPolInt::PolynomialCalcEqDist(a, b, f, n, t));
}

static double CAlglib::PolynomialCalcEqDist(const double a, const double b,
                                            double &f[], const double t) {

  int n;

  n = CAp::Len(f);

  return (CPolInt::PolynomialCalcEqDist(a, b, f, n, t));
}

static double CAlglib::PolynomialCalcCheb1(const double a, const double b,
                                           double &f[], const int n,
                                           const double t) {

  return (CPolInt::PolynomialCalcCheb1(a, b, f, n, t));
}

static double CAlglib::PolynomialCalcCheb1(const double a, const double b,
                                           double &f[], const double t) {

  int n;

  n = CAp::Len(f);

  return (CPolInt::PolynomialCalcCheb1(a, b, f, n, t));
}

static double CAlglib::PolynomialCalcCheb2(const double a, const double b,
                                           double &f[], const int n,
                                           const double t) {

  return (CPolInt::PolynomialCalcCheb2(a, b, f, n, t));
}

static double CAlglib::PolynomialCalcCheb2(const double a, const double b,
                                           double &f[], const double t) {

  int n;

  n = CAp::Len(f);

  return (CPolInt::PolynomialCalcCheb2(a, b, f, n, t));
}

static void CAlglib::Spline1DBuildLinear(double &x[], double &y[], const int n,
                                         CSpline1DInterpolantShell &c) {

  CSpline1D::Spline1DBuildLinear(x, y, n, c.GetInnerObj());

  return;
}

static void CAlglib::Spline1DBuildLinear(double &x[], double &y[],
                                         CSpline1DInterpolantShell &c) {

  int n;

  if ((CAp::Len(x) != CAp::Len(y))) {
    Print("Error while calling 'spline1dbuildlinear': looks like one of "
          "arguments has wrong size");
    CAp::exception_happened = true;
    return;
  }

  n = CAp::Len(x);

  CSpline1D::Spline1DBuildLinear(x, y, n, c.GetInnerObj());

  return;
}

static void CAlglib::Spline1DBuildCubic(double &x[], double &y[], const int n,
                                        const int boundltype,
                                        const double boundl,
                                        const int boundrtype,
                                        const double boundr,
                                        CSpline1DInterpolantShell &c) {

  CSpline1D::Spline1DBuildCubic(x, y, n, boundltype, boundl, boundrtype, boundr,
                                c.GetInnerObj());

  return;
}

static void CAlglib::Spline1DBuildCubic(double &x[], double &y[],
                                        CSpline1DInterpolantShell &c) {

  int n;
  int boundltype;
  double boundl;
  int boundrtype;
  double boundr;

  if ((CAp::Len(x) != CAp::Len(y))) {
    Print("Error while calling 'spline1dbuildcubic': looks like one of "
          "arguments has wrong size");
    CAp::exception_happened = true;
    return;
  }

  n = CAp::Len(x);
  boundltype = 0;
  boundl = 0;
  boundrtype = 0;
  boundr = 0;

  CSpline1D::Spline1DBuildCubic(x, y, n, boundltype, boundl, boundrtype, boundr,
                                c.GetInnerObj());

  return;
}

static void CAlglib::Spline1DGridDiffCubic(double &x[], double &y[],
                                           const int n, const int boundltype,
                                           const double boundl,
                                           const int boundrtype,
                                           const double boundr, double &d[]) {

  CSpline1D::Spline1DGridDiffCubic(x, y, n, boundltype, boundl, boundrtype,
                                   boundr, d);

  return;
}

static void CAlglib::Spline1DGridDiffCubic(double &x[], double &y[],
                                           double &d[]) {

  int n;
  int boundltype;
  double boundl;
  int boundrtype;
  double boundr;

  if ((CAp::Len(x) != CAp::Len(y))) {
    Print("Error while calling 'spline1dgriddiffcubic': looks like one of "
          "arguments has wrong size");
    CAp::exception_happened = true;
    return;
  }

  n = CAp::Len(x);
  boundltype = 0;
  boundl = 0;
  boundrtype = 0;
  boundr = 0;

  CSpline1D::Spline1DGridDiffCubic(x, y, n, boundltype, boundl, boundrtype,
                                   boundr, d);

  return;
}

static void CAlglib::Spline1DGridDiff2Cubic(double &x[], double &y[],
                                            const int n, const int boundltype,
                                            const double boundl,
                                            const int boundrtype,
                                            const double boundr, double &d1[],
                                            double &d2[]) {

  CSpline1D::Spline1DGridDiff2Cubic(x, y, n, boundltype, boundl, boundrtype,
                                    boundr, d1, d2);

  return;
}

static void CAlglib::Spline1DGridDiff2Cubic(double &x[], double &y[],
                                            double &d1[], double &d2[]) {

  int n;
  int boundltype;
  double boundl;
  int boundrtype;
  double boundr;

  if ((CAp::Len(x) != CAp::Len(y))) {
    Print("Error while calling 'spline1dgriddiff2cubic': looks like one of "
          "arguments has wrong size");
    CAp::exception_happened = true;
    return;
  }

  n = CAp::Len(x);
  boundltype = 0;
  boundl = 0;
  boundrtype = 0;
  boundr = 0;

  CSpline1D::Spline1DGridDiff2Cubic(x, y, n, boundltype, boundl, boundrtype,
                                    boundr, d1, d2);

  return;
}

static void CAlglib::Spline1DConvCubic(double &x[], double &y[], const int n,
                                       const int boundltype,
                                       const double boundl,
                                       const int boundrtype,
                                       const double boundr, double &x2[],
                                       int n2, double &y2[]) {

  CSpline1D::Spline1DConvCubic(x, y, n, boundltype, boundl, boundrtype, boundr,
                               x2, n2, y2);

  return;
}

static void CAlglib::Spline1DConvCubic(double &x[], double &y[], double &x2[],
                                       double &y2[]) {

  int n;
  int boundltype;
  double boundl;
  int boundrtype;
  double boundr;
  int n2;

  if ((CAp::Len(x) != CAp::Len(y))) {
    Print("Error while calling 'spline1dconvcubic': looks like one of "
          "arguments has wrong size");
    CAp::exception_happened = true;
    return;
  }

  n = CAp::Len(x);
  boundltype = 0;
  boundl = 0;
  boundrtype = 0;
  boundr = 0;
  n2 = CAp::Len(x2);

  CSpline1D::Spline1DConvCubic(x, y, n, boundltype, boundl, boundrtype, boundr,
                               x2, n2, y2);

  return;
}

static void CAlglib::Spline1DConvDiffCubic(double &x[], double &y[],
                                           const int n, const int boundltype,
                                           const double boundl,
                                           const int boundrtype,
                                           const double boundr, double &x2[],
                                           int n2, double &y2[], double &d2[]) {

  CSpline1D::Spline1DConvDiffCubic(x, y, n, boundltype, boundl, boundrtype,
                                   boundr, x2, n2, y2, d2);

  return;
}

static void CAlglib::Spline1DConvDiffCubic(double &x[], double &y[],
                                           double &x2[], double &y2[],
                                           double &d2[]) {

  int n;
  int boundltype;
  double boundl;
  int boundrtype;
  double boundr;
  int n2;

  if ((CAp::Len(x) != CAp::Len(y))) {
    Print("Error while calling 'spline1dconvdiffcubic': looks like one of "
          "arguments has wrong size");
    CAp::exception_happened = true;
    return;
  }

  n = CAp::Len(x);
  boundltype = 0;
  boundl = 0;
  boundrtype = 0;
  boundr = 0;
  n2 = CAp::Len(x2);

  CSpline1D::Spline1DConvDiffCubic(x, y, n, boundltype, boundl, boundrtype,
                                   boundr, x2, n2, y2, d2);

  return;
}

static void CAlglib::Spline1DConvDiff2Cubic(
    double &x[], double &y[], const int n, const int boundltype,
    const double boundl, const int boundrtype, const double boundr,
    double &x2[], const int n2, double &y2[], double &d2[], double &dd2[]) {

  CSpline1D::Spline1DConvDiff2Cubic(x, y, n, boundltype, boundl, boundrtype,
                                    boundr, x2, n2, y2, d2, dd2);

  return;
}

static void CAlglib::Spline1DConvDiff2Cubic(double &x[], double &y[],
                                            double &x2[], double &y2[],
                                            double &d2[], double &dd2[]) {

  int n;
  int boundltype;
  double boundl;
  int boundrtype;
  double boundr;
  int n2;

  if ((CAp::Len(x) != CAp::Len(y))) {
    Print("Error while calling 'spline1dconvdiff2cubic': looks like one of "
          "arguments has wrong size");
    CAp::exception_happened = true;
    return;
  }

  n = CAp::Len(x);
  boundltype = 0;
  boundl = 0;
  boundrtype = 0;
  boundr = 0;
  n2 = CAp::Len(x2);

  CSpline1D::Spline1DConvDiff2Cubic(x, y, n, boundltype, boundl, boundrtype,
                                    boundr, x2, n2, y2, d2, dd2);

  return;
}

static void CAlglib::Spline1DBuildCatmullRom(double &x[], double &y[],
                                             const int n, const int boundtype,
                                             const double tension,
                                             CSpline1DInterpolantShell &c) {

  CSpline1D::Spline1DBuildCatmullRom(x, y, n, boundtype, tension,
                                     c.GetInnerObj());

  return;
}

static void CAlglib::Spline1DBuildCatmullRom(double &x[], double &y[],
                                             CSpline1DInterpolantShell &c) {

  int n;
  int boundtype;
  double tension;

  if ((CAp::Len(x) != CAp::Len(y))) {
    Print("Error while calling 'spline1dbuildcatmullrom': looks like one of "
          "arguments has wrong size");
    CAp::exception_happened = true;
    return;
  }

  n = CAp::Len(x);
  boundtype = 0;
  tension = 0;

  CSpline1D::Spline1DBuildCatmullRom(x, y, n, boundtype, tension,
                                     c.GetInnerObj());

  return;
}

static void CAlglib::Spline1DBuildHermite(double &x[], double &y[], double &d[],
                                          const int n,
                                          CSpline1DInterpolantShell &c) {

  CSpline1D::Spline1DBuildHermite(x, y, d, n, c.GetInnerObj());

  return;
}

static void CAlglib::Spline1DBuildHermite(double &x[], double &y[], double &d[],
                                          CSpline1DInterpolantShell &c) {

  int n;

  if ((CAp::Len(x) != CAp::Len(y)) || (CAp::Len(x) != CAp::Len(d))) {
    Print("Error while calling 'spline1dbuildhermite': looks like one of "
          "arguments has wrong size");
    CAp::exception_happened = true;
    return;
  }

  n = CAp::Len(x);

  CSpline1D::Spline1DBuildHermite(x, y, d, n, c.GetInnerObj());

  return;
}

static void CAlglib::Spline1DBuildAkima(double &x[], double &y[], const int n,
                                        CSpline1DInterpolantShell &c) {

  CSpline1D::Spline1DBuildAkima(x, y, n, c.GetInnerObj());

  return;
}

static void CAlglib::Spline1DBuildAkima(double &x[], double &y[],
                                        CSpline1DInterpolantShell &c) {

  int n;

  if ((CAp::Len(x) != CAp::Len(y))) {
    Print("Error while calling 'spline1dbuildakima': looks like one of "
          "arguments has wrong size");
    CAp::exception_happened = true;
    return;
  }

  n = CAp::Len(x);

  CSpline1D::Spline1DBuildAkima(x, y, n, c.GetInnerObj());

  return;
}

static double CAlglib::Spline1DCalc(CSpline1DInterpolantShell &c,
                                    const double x) {

  return (CSpline1D::Spline1DCalc(c.GetInnerObj(), x));
}

static void CAlglib::Spline1DDiff(CSpline1DInterpolantShell &c, const double x,
                                  double &s, double &ds, double &d2s) {

  s = 0;
  ds = 0;
  d2s = 0;

  CSpline1D::Spline1DDiff(c.GetInnerObj(), x, s, ds, d2s);

  return;
}

static void CAlglib::Spline1DUnpack(CSpline1DInterpolantShell &c, int &n,
                                    CMatrixDouble &tbl) {

  n = 0;

  CSpline1D::Spline1DUnpack(c.GetInnerObj(), n, tbl);

  return;
}

static void CAlglib::Spline1DLinTransX(CSpline1DInterpolantShell &c,
                                       const double a, const double b) {

  CSpline1D::Spline1DLinTransX(c.GetInnerObj(), a, b);

  return;
}

static void CAlglib::Spline1DLinTransY(CSpline1DInterpolantShell &c,
                                       const double a, const double b) {

  CSpline1D::Spline1DLinTransY(c.GetInnerObj(), a, b);

  return;
}

static double CAlglib::Spline1DIntegrate(CSpline1DInterpolantShell &c,
                                         const double x) {

  return (CSpline1D::Spline1DIntegrate(c.GetInnerObj(), x));
}

static void CAlglib::PolynomialFit(double &x[], double &y[], const int n,
                                   const int m, int &info,
                                   CBarycentricInterpolantShell &p,
                                   CPolynomialFitReportShell &rep) {

  info = 0;

  CLSFit::PolynomialFit(x, y, n, m, info, p.GetInnerObj(), rep.GetInnerObj());

  return;
}

static void CAlglib::PolynomialFit(double &x[], double &y[], const int m,
                                   int &info, CBarycentricInterpolantShell &p,
                                   CPolynomialFitReportShell &rep) {

  int n;

  if ((CAp::Len(x) != CAp::Len(y))) {
    Print("Error while calling 'polynomialfit': looks like one of arguments "
          "has wrong size");
    CAp::exception_happened = true;
    return;
  }

  info = 0;
  n = CAp::Len(x);

  CLSFit::PolynomialFit(x, y, n, m, info, p.GetInnerObj(), rep.GetInnerObj());

  return;
}

static void CAlglib::PolynomialFitWC(double &x[], double &y[], double &w[],
                                     const int n, double &xc[], double &yc[],
                                     int &dc[], const int k, const int m,
                                     int &info, CBarycentricInterpolantShell &p,
                                     CPolynomialFitReportShell &rep) {

  info = 0;

  CLSFit::PolynomialFitWC(x, y, w, n, xc, yc, dc, k, m, info, p.GetInnerObj(),
                          rep.GetInnerObj());

  return;
}

static void CAlglib::PolynomialFitWC(double &x[], double &y[], double &w[],
                                     double &xc[], double &yc[], int &dc[],
                                     const int m, int &info,
                                     CBarycentricInterpolantShell &p,
                                     CPolynomialFitReportShell &rep) {

  int n;
  int k;

  if ((CAp::Len(x) != CAp::Len(y)) || (CAp::Len(x) != CAp::Len(w))) {
    Print("Error while calling 'polynomialfitwc': looks like one of arguments "
          "has wrong size");
    CAp::exception_happened = true;
    return;
  }

  if ((CAp::Len(xc) != CAp::Len(yc)) || (CAp::Len(xc) != CAp::Len(dc))) {
    Print("Error while calling 'polynomialfitwc': looks like one of arguments "
          "has wrong size");
    CAp::exception_happened = true;
    return;
  }

  info = 0;
  n = CAp::Len(x);
  k = CAp::Len(xc);

  CLSFit::PolynomialFitWC(x, y, w, n, xc, yc, dc, k, m, info, p.GetInnerObj(),
                          rep.GetInnerObj());

  return;
}

static void CAlglib::BarycentricFitFloaterHormannWC(
    double &x[], double &y[], double &w[], const int n, double &xc[],
    double &yc[], int &dc[], const int k, const int m, int &info,
    CBarycentricInterpolantShell &b, CBarycentricFitReportShell &rep) {

  info = 0;

  CLSFit::BarycentricFitFloaterHormannWC(x, y, w, n, xc, yc, dc, k, m, info,
                                         b.GetInnerObj(), rep.GetInnerObj());

  return;
}

static void CAlglib::BarycentricFitFloaterHormann(
    double &x[], double &y[], const int n, const int m, int &info,
    CBarycentricInterpolantShell &b, CBarycentricFitReportShell &rep) {

  info = 0;

  CLSFit::BarycentricFitFloaterHormann(x, y, n, m, info, b.GetInnerObj(),
                                       rep.GetInnerObj());

  return;
}

static void CAlglib::Spline1DFitPenalized(double &x[], double &y[], const int n,
                                          const int m, const double rho,
                                          int &info,
                                          CSpline1DInterpolantShell &s,
                                          CSpline1DFitReportShell &rep) {

  info = 0;

  CLSFit::Spline1DFitPenalized(x, y, n, m, rho, info, s.GetInnerObj(),
                               rep.GetInnerObj());

  return;
}

static void CAlglib::Spline1DFitPenalized(double &x[], double &y[], const int m,
                                          const double rho, int &info,
                                          CSpline1DInterpolantShell &s,
                                          CSpline1DFitReportShell &rep) {

  int n;

  if ((CAp::Len(x) != CAp::Len(y))) {
    Print("Error while calling 'spline1dfitpenalized': looks like one of "
          "arguments has wrong size");
    CAp::exception_happened = true;
    return;
  }

  info = 0;
  n = CAp::Len(x);

  CLSFit::Spline1DFitPenalized(x, y, n, m, rho, info, s.GetInnerObj(),
                               rep.GetInnerObj());

  return;
}

static void CAlglib::Spline1DFitPenalizedW(double &x[], double &y[],
                                           double &w[], const int n,
                                           const int m, const double rho,
                                           int &info,
                                           CSpline1DInterpolantShell &s,
                                           CSpline1DFitReportShell &rep) {

  info = 0;

  CLSFit::Spline1DFitPenalizedW(x, y, w, n, m, rho, info, s.GetInnerObj(),
                                rep.GetInnerObj());

  return;
}

static void CAlglib::Spline1DFitPenalizedW(double &x[], double &y[],
                                           double &w[], const int m,
                                           const double rho, int &info,
                                           CSpline1DInterpolantShell &s,
                                           CSpline1DFitReportShell &rep) {

  int n;

  if ((CAp::Len(x) != CAp::Len(y)) || (CAp::Len(x) != CAp::Len(w))) {
    Print("Error while calling 'spline1dfitpenalizedw': looks like one of "
          "arguments has wrong size");
    CAp::exception_happened = true;
    return;
  }

  info = 0;
  n = CAp::Len(x);

  CLSFit::Spline1DFitPenalizedW(x, y, w, n, m, rho, info, s.GetInnerObj(),
                                rep.GetInnerObj());

  return;
}

static void CAlglib::Spline1DFitCubicWC(double &x[], double &y[], double &w[],
                                        const int n, double &xc[], double &yc[],
                                        int &dc[], const int k, const int m,
                                        int &info, CSpline1DInterpolantShell &s,
                                        CSpline1DFitReportShell &rep) {

  info = 0;

  CLSFit::Spline1DFitCubicWC(x, y, w, n, xc, yc, dc, k, m, info,
                             s.GetInnerObj(), rep.GetInnerObj());

  return;
}

static void CAlglib::Spline1DFitCubicWC(double &x[], double &y[], double &w[],
                                        double &xc[], double &yc[], int &dc[],
                                        const int m, int &info,
                                        CSpline1DInterpolantShell &s,
                                        CSpline1DFitReportShell &rep) {

  int n;
  int k;

  if ((CAp::Len(x) != CAp::Len(y)) || (CAp::Len(x) != CAp::Len(w))) {
    Print("Error while calling 'spline1dfitcubicwc': looks like one of "
          "arguments has wrong size");
    CAp::exception_happened = true;
    return;
  }

  if ((CAp::Len(xc) != CAp::Len(yc)) || (CAp::Len(xc) != CAp::Len(dc))) {
    Print("Error while calling 'spline1dfitcubicwc': looks like one of "
          "arguments has wrong size");
    CAp::exception_happened = true;
    return;
  }

  info = 0;
  n = CAp::Len(x);
  k = CAp::Len(xc);

  CLSFit::Spline1DFitCubicWC(x, y, w, n, xc, yc, dc, k, m, info,
                             s.GetInnerObj(), rep.GetInnerObj());

  return;
}

static void CAlglib::Spline1DFitHermiteWC(double &x[], double &y[], double &w[],
                                          const int n, double &xc[],
                                          double &yc[], int &dc[], const int k,
                                          const int m, int &info,
                                          CSpline1DInterpolantShell &s,
                                          CSpline1DFitReportShell &rep) {

  info = 0;

  CLSFit::Spline1DFitHermiteWC(x, y, w, n, xc, yc, dc, k, m, info,
                               s.GetInnerObj(), rep.GetInnerObj());

  return;
}

static void CAlglib::Spline1DFitHermiteWC(double &x[], double &y[], double &w[],
                                          double &xc[], double &yc[], int &dc[],
                                          const int m, int &info,
                                          CSpline1DInterpolantShell &s,
                                          CSpline1DFitReportShell &rep) {

  int n;
  int k;

  if ((CAp::Len(x) != CAp::Len(y)) || (CAp::Len(x) != CAp::Len(w))) {
    Print("Error while calling 'spline1dfithermitewc': looks like one of "
          "arguments has wrong size");
    CAp::exception_happened = true;
    return;
  }

  if ((CAp::Len(xc) != CAp::Len(yc)) || (CAp::Len(xc) != CAp::Len(dc))) {
    Print("Error while calling 'spline1dfithermitewc': looks like one of "
          "arguments has wrong size");
    CAp::exception_happened = true;
    return;
  }

  info = 0;
  n = CAp::Len(x);
  k = CAp::Len(xc);

  CLSFit::Spline1DFitHermiteWC(x, y, w, n, xc, yc, dc, k, m, info,
                               s.GetInnerObj(), rep.GetInnerObj());

  return;
}

static void CAlglib::Spline1DFitCubic(double &x[], double &y[], const int n,
                                      const int m, int &info,
                                      CSpline1DInterpolantShell &s,
                                      CSpline1DFitReportShell &rep) {

  info = 0;

  CLSFit::Spline1DFitCubic(x, y, n, m, info, s.GetInnerObj(),
                           rep.GetInnerObj());

  return;
}

static void CAlglib::Spline1DFitCubic(double &x[], double &y[], const int m,
                                      int &info, CSpline1DInterpolantShell &s,
                                      CSpline1DFitReportShell &rep) {

  int n;

  if ((CAp::Len(x) != CAp::Len(y))) {
    Print("Error while calling 'spline1dfitcubic': looks like one of arguments "
          "has wrong size");
    CAp::exception_happened = true;
    return;
  }

  info = 0;
  n = CAp::Len(x);

  CLSFit::Spline1DFitCubic(x, y, n, m, info, s.GetInnerObj(),
                           rep.GetInnerObj());

  return;
}

static void CAlglib::Spline1DFitHermite(double &x[], double &y[], const int n,
                                        const int m, int &info,
                                        CSpline1DInterpolantShell &s,
                                        CSpline1DFitReportShell &rep) {

  info = 0;

  CLSFit::Spline1DFitHermite(x, y, n, m, info, s.GetInnerObj(),
                             rep.GetInnerObj());

  return;
}

static void CAlglib::Spline1DFitHermite(double &x[], double &y[], const int m,
                                        int &info, CSpline1DInterpolantShell &s,
                                        CSpline1DFitReportShell &rep) {

  int n;

  if ((CAp::Len(x) != CAp::Len(y))) {
    Print("Error while calling 'spline1dfithermite': looks like one of "
          "arguments has wrong size");
    CAp::exception_happened = true;
    return;
  }

  info = 0;
  n = CAp::Len(x);

  CLSFit::Spline1DFitHermite(x, y, n, m, info, s.GetInnerObj(),
                             rep.GetInnerObj());

  return;
}

static void CAlglib::LSFitLinearW(double &y[], double &w[],
                                  CMatrixDouble &fmatrix, const int n,
                                  const int m, int &info, double &c[],
                                  CLSFitReportShell &rep) {

  info = 0;

  CLSFit::LSFitLinearW(y, w, fmatrix, n, m, info, c, rep.GetInnerObj());

  return;
}

static void CAlglib::LSFitLinearW(double &y[], double &w[],
                                  CMatrixDouble &fmatrix, int &info,
                                  double &c[], CLSFitReportShell &rep) {

  int n;
  int m;

  if ((CAp::Len(y) != CAp::Len(w)) || (CAp::Len(y) != CAp::Rows(fmatrix))) {
    Print("Error while calling 'lsfitlinearw': looks like one of arguments has "
          "wrong size");
    CAp::exception_happened = true;
    return;
  }

  info = 0;
  n = CAp::Len(y);
  m = CAp::Cols(fmatrix);

  CLSFit::LSFitLinearW(y, w, fmatrix, n, m, info, c, rep.GetInnerObj());

  return;
}

static void CAlglib::LSFitLinearWC(double &y[], double &w[],
                                   CMatrixDouble &fmatrix,
                                   CMatrixDouble &cmatrix, const int n,
                                   const int m, const int k, int &info,
                                   double &c[], CLSFitReportShell &rep) {

  info = 0;

  CLSFit::LSFitLinearWC(y, w, fmatrix, cmatrix, n, m, k, info, c,
                        rep.GetInnerObj());

  return;
}

static void CAlglib::LSFitLinearWC(double &y[], double &w[],
                                   CMatrixDouble &fmatrix,
                                   CMatrixDouble &cmatrix, int &info,
                                   double &c[], CLSFitReportShell &rep) {

  int n;
  int m;
  int k;

  if ((CAp::Len(y) != CAp::Len(w)) || (CAp::Len(y) != CAp::Rows(fmatrix))) {
    Print("Error while calling 'lsfitlinearwc': looks like one of arguments "
          "has wrong size");
    CAp::exception_happened = true;
    return;
  }

  if ((CAp::Cols(fmatrix) != CAp::Cols(cmatrix) - 1)) {
    Print("Error while calling 'lsfitlinearwc': looks like one of arguments "
          "has wrong size");
    CAp::exception_happened = true;
    return;
  }

  info = 0;
  n = CAp::Len(y);
  m = CAp::Cols(fmatrix);
  k = CAp::Rows(cmatrix);

  CLSFit::LSFitLinearWC(y, w, fmatrix, cmatrix, n, m, k, info, c,
                        rep.GetInnerObj());

  return;
}

static void CAlglib::LSFitLinear(double &y[], CMatrixDouble &fmatrix,
                                 const int n, const int m, int &info,
                                 double &c[], CLSFitReportShell &rep) {

  info = 0;

  CLSFit::LSFitLinear(y, fmatrix, n, m, info, c, rep.GetInnerObj());

  return;
}

static void CAlglib::LSFitLinear(double &y[], CMatrixDouble &fmatrix, int &info,
                                 double &c[], CLSFitReportShell &rep) {

  int n;
  int m;

  if ((CAp::Len(y) != CAp::Rows(fmatrix))) {
    Print("Error while calling 'lsfitlinear': looks like one of arguments has "
          "wrong size");
    CAp::exception_happened = true;
    return;
  }

  info = 0;
  n = CAp::Len(y);
  m = CAp::Cols(fmatrix);

  CLSFit::LSFitLinear(y, fmatrix, n, m, info, c, rep.GetInnerObj());

  return;
}

static void CAlglib::LSFitLinearC(double &y[], CMatrixDouble &fmatrix,
                                  CMatrixDouble &cmatrix, const int n,
                                  const int m, const int k, int &info,
                                  double &c[], CLSFitReportShell &rep) {

  info = 0;

  CLSFit::LSFitLinearC(y, fmatrix, cmatrix, n, m, k, info, c,
                       rep.GetInnerObj());

  return;
}

static void CAlglib::LSFitLinearC(double &y[], CMatrixDouble &fmatrix,
                                  CMatrixDouble &cmatrix, int &info,
                                  double &c[], CLSFitReportShell &rep) {

  int n;
  int m;
  int k;

  if ((CAp::Len(y) != CAp::Rows(fmatrix))) {
    Print("Error while calling 'lsfitlinearc': looks like one of arguments has "
          "wrong size");
    CAp::exception_happened = true;
    return;
  }

  if ((CAp::Cols(fmatrix) != CAp::Cols(cmatrix) - 1)) {
    Print("Error while calling 'lsfitlinearc': looks like one of arguments has "
          "wrong size");
    CAp::exception_happened = true;
    return;
  }

  info = 0;
  n = CAp::Len(y);
  m = CAp::Cols(fmatrix);
  k = CAp::Rows(cmatrix);

  CLSFit::LSFitLinearC(y, fmatrix, cmatrix, n, m, k, info, c,
                       rep.GetInnerObj());

  return;
}

static void CAlglib::LSFitCreateWF(CMatrixDouble &x, double &y[], double &w[],
                                   double &c[], const int n, const int m,
                                   const int k, const double diffstep,
                                   CLSFitStateShell &state) {

  CLSFit::LSFitCreateWF(x, y, w, c, n, m, k, diffstep, state.GetInnerObj());

  return;
}

static void CAlglib::LSFitCreateWF(CMatrixDouble &x, double &y[], double &w[],
                                   double &c[], const double diffstep,
                                   CLSFitStateShell &state) {

  int n;
  int m;
  int k;

  if ((CAp::Rows(x) != CAp::Len(y)) || (CAp::Rows(x) != CAp::Len(w))) {
    Print("Error while calling 'lsfitcreatewf': looks like one of arguments "
          "has wrong size");
    CAp::exception_happened = true;
    return;
  }

  n = CAp::Rows(x);
  m = CAp::Cols(x);
  k = CAp::Len(c);

  CLSFit::LSFitCreateWF(x, y, w, c, n, m, k, diffstep, state.GetInnerObj());

  return;
}

static void CAlglib::LSFitCreateF(CMatrixDouble &x, double &y[], double &c[],
                                  const int n, const int m, const int k,
                                  const double diffstep,
                                  CLSFitStateShell &state) {

  CLSFit::LSFitCreateF(x, y, c, n, m, k, diffstep, state.GetInnerObj());

  return;
}

static void CAlglib::LSFitCreateF(CMatrixDouble &x, double &y[], double &c[],
                                  const double diffstep,
                                  CLSFitStateShell &state) {

  int n;
  int m;
  int k;

  if ((CAp::Rows(x) != CAp::Len(y))) {
    Print("Error while calling 'lsfitcreatef': looks like one of arguments has "
          "wrong size");
    CAp::exception_happened = true;
    return;
  }

  n = CAp::Rows(x);
  m = CAp::Cols(x);
  k = CAp::Len(c);

  CLSFit::LSFitCreateF(x, y, c, n, m, k, diffstep, state.GetInnerObj());

  return;
}

static void CAlglib::LSFitCreateWFG(CMatrixDouble &x, double &y[], double &w[],
                                    double &c[], const int n, const int m,
                                    const int k, const bool cheapfg,
                                    CLSFitStateShell &state) {

  CLSFit::LSFitCreateWFG(x, y, w, c, n, m, k, cheapfg, state.GetInnerObj());

  return;
}

static void CAlglib::LSFitCreateWFG(CMatrixDouble &x, double &y[], double &w[],
                                    double &c[], const bool cheapfg,
                                    CLSFitStateShell &state) {

  int n;
  int m;
  int k;

  if ((CAp::Rows(x) != CAp::Len(y)) || (CAp::Rows(x) != CAp::Len(w))) {
    Print("Error while calling 'lsfitcreatewfg': looks like one of arguments "
          "has wrong size");
    CAp::exception_happened = true;
    return;
  }

  n = CAp::Rows(x);
  m = CAp::Cols(x);
  k = CAp::Len(c);

  CLSFit::LSFitCreateWFG(x, y, w, c, n, m, k, cheapfg, state.GetInnerObj());

  return;
}

static void CAlglib::LSFitCreateFG(CMatrixDouble &x, double &y[], double &c[],
                                   const int n, const int m, const int k,
                                   const bool cheapfg,
                                   CLSFitStateShell &state) {

  CLSFit::LSFitCreateFG(x, y, c, n, m, k, cheapfg, state.GetInnerObj());

  return;
}

static void CAlglib::LSFitCreateFG(CMatrixDouble &x, double &y[], double &c[],
                                   const bool cheapfg,
                                   CLSFitStateShell &state) {

  int n;
  int m;
  int k;

  if ((CAp::Rows(x) != CAp::Len(y))) {
    Print("Error while calling 'lsfitcreatefg': looks like one of arguments "
          "has wrong size");
    CAp::exception_happened = true;
    return;
  }

  n = CAp::Rows(x);
  m = CAp::Cols(x);
  k = CAp::Len(c);

  CLSFit::LSFitCreateFG(x, y, c, n, m, k, cheapfg, state.GetInnerObj());

  return;
}

static void CAlglib::LSFitCreateWFGH(CMatrixDouble &x, double &y[], double &w[],
                                     double &c[], const int n, const int m,
                                     const int k, CLSFitStateShell &state) {

  CLSFit::LSFitCreateWFGH(x, y, w, c, n, m, k, state.GetInnerObj());

  return;
}

static void CAlglib::LSFitCreateWFGH(CMatrixDouble &x, double &y[], double &w[],
                                     double &c[], CLSFitStateShell &state) {

  int n;
  int m;
  int k;

  if ((CAp::Rows(x) != CAp::Len(y)) || (CAp::Rows(x) != CAp::Len(w))) {
    Print("Error while calling 'lsfitcreatewfgh': looks like one of arguments "
          "has wrong size");
    CAp::exception_happened = true;
    return;
  }

  n = CAp::Rows(x);
  m = CAp::Cols(x);
  k = CAp::Len(c);

  CLSFit::LSFitCreateWFGH(x, y, w, c, n, m, k, state.GetInnerObj());

  return;
}

static void CAlglib::LSFitCreateFGH(CMatrixDouble &x, double &y[], double &c[],
                                    const int n, const int m, const int k,
                                    CLSFitStateShell &state) {

  CLSFit::LSFitCreateFGH(x, y, c, n, m, k, state.GetInnerObj());

  return;
}

static void CAlglib::LSFitCreateFGH(CMatrixDouble &x, double &y[], double &c[],
                                    CLSFitStateShell &state) {

  int n;
  int m;
  int k;

  if ((CAp::Rows(x) != CAp::Len(y))) {
    Print("Error while calling 'lsfitcreatefgh': looks like one of arguments "
          "has wrong size");
    CAp::exception_happened = true;
    return;
  }

  n = CAp::Rows(x);
  m = CAp::Cols(x);
  k = CAp::Len(c);

  CLSFit::LSFitCreateFGH(x, y, c, n, m, k, state.GetInnerObj());

  return;
}

static void CAlglib::LSFitSetCond(CLSFitStateShell &state, const double epsf,
                                  const double epsx, const int maxits) {

  CLSFit::LSFitSetCond(state.GetInnerObj(), epsf, epsx, maxits);

  return;
}

static void CAlglib::LSFitSetStpMax(CLSFitStateShell &state,
                                    const double stpmax) {

  CLSFit::LSFitSetStpMax(state.GetInnerObj(), stpmax);

  return;
}

static void CAlglib::LSFitSetXRep(CLSFitStateShell &state,
                                  const bool needxrep) {

  CLSFit::LSFitSetXRep(state.GetInnerObj(), needxrep);

  return;
}

static void CAlglib::LSFitSetScale(CLSFitStateShell &state, double &s[]) {

  CLSFit::LSFitSetScale(state.GetInnerObj(), s);

  return;
}

static void CAlglib::LSFitSetBC(CLSFitStateShell &state, double &bndl[],
                                double &bndu[]) {

  CLSFit::LSFitSetBC(state.GetInnerObj(), bndl, bndu);

  return;
}

static bool CAlglib::LSFitIteration(CLSFitStateShell &state) {

  return (CLSFit::LSFitIteration(state.GetInnerObj()));
}

static void CAlglib::LSFitFit(CLSFitStateShell &state,
                              CNDimensional_PFunc &func, CNDimensional_Rep &rep,
                              bool rep_status, CObject &obj) {

  while (CAlglib::LSFitIteration(state)) {

    if (state.GetNeedF()) {
      func.PFunc(state.GetInnerObj().m_c, state.GetInnerObj().m_x,
                 state.GetInnerObj().m_f, obj);

      continue;
    }

    if (state.GetInnerObj().m_xupdated) {

      if (rep_status)
        rep.Rep(state.GetInnerObj().m_c, state.GetInnerObj().m_f, obj);

      continue;
    }
    Print("ALGLIB: error in 'lsfitfit' (some derivatives were not provided?)");
    CAp::exception_happened = true;
    return;
  }
}

static void CAlglib::LSFitFit(CLSFitStateShell &state,
                              CNDimensional_PFunc &func,
                              CNDimensional_PGrad &grad, CNDimensional_Rep &rep,
                              bool rep_status, CObject &obj) {

  while (CAlglib::LSFitIteration(state)) {

    if (state.GetNeedF()) {
      func.PFunc(state.GetInnerObj().m_c, state.GetInnerObj().m_x,
                 state.GetInnerObj().m_f, obj);

      continue;
    }

    if (state.GetNeedFG()) {
      grad.PGrad(state.GetInnerObj().m_c, state.GetInnerObj().m_x,
                 state.GetInnerObj().m_f, state.GetInnerObj().m_g, obj);

      continue;
    }

    if (state.GetInnerObj().m_xupdated) {

      if (rep_status)
        rep.Rep(state.GetInnerObj().m_c, state.GetInnerObj().m_f, obj);

      continue;
    }
    Print("ALGLIB: error in 'lsfitfit' (some derivatives were not provided?)");
    CAp::exception_happened = true;
    return;
  }
}

static void CAlglib::LSFitFit(CLSFitStateShell &state,
                              CNDimensional_PFunc &func,
                              CNDimensional_PGrad &grad,
                              CNDimensional_PHess &hess, CNDimensional_Rep &rep,
                              bool rep_status, CObject &obj) {

  while (CAlglib::LSFitIteration(state)) {

    if (state.GetNeedF()) {
      func.PFunc(state.GetInnerObj().m_c, state.GetInnerObj().m_x,
                 state.GetInnerObj().m_f, obj);

      continue;
    }

    if (state.GetNeedFG()) {
      grad.PGrad(state.GetInnerObj().m_c, state.GetInnerObj().m_x,
                 state.GetInnerObj().m_f, state.GetInnerObj().m_g, obj);

      continue;
    }

    if (state.GetNeedFGH()) {
      hess.PHess(state.GetInnerObj().m_c, state.GetInnerObj().m_x,
                 state.GetInnerObj().m_f, state.GetInnerObj().m_g,
                 state.GetInnerObj().m_h, obj);

      continue;
    }

    if (state.GetInnerObj().m_xupdated) {

      if (rep_status)
        rep.Rep(state.GetInnerObj().m_c, state.GetInnerObj().m_f, obj);

      continue;
    }
    Print("ALGLIB: error in 'lsfitfit' (some derivatives were not provided?)");
    CAp::exception_happened = true;
    return;
  }
}

static void CAlglib::LSFitResults(CLSFitStateShell &state, int &info,
                                  double &c[], CLSFitReportShell &rep) {

  info = 0;

  CLSFit::LSFitResults(state.GetInnerObj(), info, c, rep.GetInnerObj());

  return;
}

static void CAlglib::PSpline2Build(CMatrixDouble &xy, const int n, const int st,
                                   const int pt, CPSpline2InterpolantShell &p) {

  CPSpline::PSpline2Build(xy, n, st, pt, p.GetInnerObj());

  return;
}

static void CAlglib::PSpline3Build(CMatrixDouble &xy, const int n, const int st,
                                   const int pt, CPSpline3InterpolantShell &p) {

  CPSpline::PSpline3Build(xy, n, st, pt, p.GetInnerObj());

  return;
}

static void CAlglib::PSpline2BuildPeriodic(CMatrixDouble &xy, const int n,
                                           const int st, const int pt,
                                           CPSpline2InterpolantShell &p) {

  CPSpline::PSpline2BuildPeriodic(xy, n, st, pt, p.GetInnerObj());

  return;
}

static void CAlglib::PSpline3BuildPeriodic(CMatrixDouble &xy, const int n,
                                           const int st, const int pt,
                                           CPSpline3InterpolantShell &p) {

  CPSpline::PSpline3BuildPeriodic(xy, n, st, pt, p.GetInnerObj());

  return;
}

static void CAlglib::PSpline2ParameterValues(CPSpline2InterpolantShell &p,
                                             int &n, double &t[]) {

  n = 0;

  CPSpline::PSpline2ParameterValues(p.GetInnerObj(), n, t);

  return;
}

static void CAlglib::PSpline3ParameterValues(CPSpline3InterpolantShell &p,
                                             int &n, double &t[]) {

  n = 0;

  CPSpline::PSpline3ParameterValues(p.GetInnerObj(), n, t);

  return;
}

static void CAlglib::PSpline2Calc(CPSpline2InterpolantShell &p, const double t,
                                  double &x, double &y) {

  x = 0;
  y = 0;

  CPSpline::PSpline2Calc(p.GetInnerObj(), t, x, y);

  return;
}

static void CAlglib::PSpline3Calc(CPSpline3InterpolantShell &p, const double t,
                                  double &x, double &y, double &z) {

  x = 0;
  y = 0;
  z = 0;

  CPSpline::PSpline3Calc(p.GetInnerObj(), t, x, y, z);

  return;
}

static void CAlglib::PSpline2Tangent(CPSpline2InterpolantShell &p,
                                     const double t, double &x, double &y) {

  x = 0;
  y = 0;

  CPSpline::PSpline2Tangent(p.GetInnerObj(), t, x, y);

  return;
}

static void CAlglib::PSpline3Tangent(CPSpline3InterpolantShell &p,
                                     const double t, double &x, double &y,
                                     double &z) {

  x = 0;
  y = 0;
  z = 0;

  CPSpline::PSpline3Tangent(p.GetInnerObj(), t, x, y, z);

  return;
}

static void CAlglib::PSpline2Diff(CPSpline2InterpolantShell &p, const double t,
                                  double &x, double &dx, double &y,
                                  double &dy) {

  x = 0;
  dx = 0;
  y = 0;
  dy = 0;

  CPSpline::PSpline2Diff(p.GetInnerObj(), t, x, dx, y, dy);

  return;
}

static void CAlglib::PSpline3Diff(CPSpline3InterpolantShell &p, const double t,
                                  double &x, double &dx, double &y, double &dy,
                                  double &z, double &dz) {

  x = 0;
  dx = 0;
  y = 0;
  dy = 0;
  z = 0;
  dz = 0;

  CPSpline::PSpline3Diff(p.GetInnerObj(), t, x, dx, y, dy, z, dz);

  return;
}

static void CAlglib::PSpline2Diff2(CPSpline2InterpolantShell &p, const double t,
                                   double &x, double &dx, double &d2x,
                                   double &y, double &dy, double &d2y) {

  x = 0;
  dx = 0;
  d2x = 0;
  y = 0;
  dy = 0;
  d2y = 0;

  CPSpline::PSpline2Diff2(p.GetInnerObj(), t, x, dx, d2x, y, dy, d2y);

  return;
}

static void CAlglib::PSpline3Diff2(CPSpline3InterpolantShell &p, const double t,
                                   double &x, double &dx, double &d2x,
                                   double &y, double &dy, double &d2y,
                                   double &z, double &dz, double &d2z) {

  x = 0;
  dx = 0;
  d2x = 0;
  y = 0;
  dy = 0;
  d2y = 0;
  z = 0;
  dz = 0;
  d2z = 0;

  CPSpline::PSpline3Diff2(p.GetInnerObj(), t, x, dx, d2x, y, dy, d2y, z, dz,
                          d2z);

  return;
}

static double CAlglib::PSpline2ArcLength(CPSpline2InterpolantShell &p,
                                         const double a, const double b) {

  return (CPSpline::PSpline2ArcLength(p.GetInnerObj(), a, b));
}

static double CAlglib::PSpline3ArcLength(CPSpline3InterpolantShell &p,
                                         const double a, const double b) {

  return (CPSpline::PSpline3ArcLength(p.GetInnerObj(), a, b));
}

static void CAlglib::Spline2DBuildBilinear(double &x[], double &y[],
                                           CMatrixDouble &f, const int m,
                                           const int n,
                                           CSpline2DInterpolantShell &c) {

  CSpline2D::Spline2DBuildBilinear(x, y, f, m, n, c.GetInnerObj());

  return;
}

static void CAlglib::Spline2DBuildBicubic(double &x[], double &y[],
                                          CMatrixDouble &f, const int m,
                                          const int n,
                                          CSpline2DInterpolantShell &c) {

  CSpline2D::Spline2DBuildBicubic(x, y, f, m, n, c.GetInnerObj());

  return;
}

static double CAlglib::Spline2DCalc(CSpline2DInterpolantShell &c,
                                    const double x, const double y) {

  return (CSpline2D::Spline2DCalc(c.GetInnerObj(), x, y));
}

static void CAlglib::Spline2DDiff(CSpline2DInterpolantShell &c, const double x,
                                  const double y, double &f, double &fx,
                                  double &fy, double &fxy) {

  f = 0;
  fx = 0;
  fy = 0;
  fxy = 0;

  CSpline2D::Spline2DDiff(c.GetInnerObj(), x, y, f, fx, fy, fxy);

  return;
}

static void CAlglib::Spline2DUnpack(CSpline2DInterpolantShell &c, int &m,
                                    int &n, CMatrixDouble &tbl) {

  m = 0;
  n = 0;

  CSpline2D::Spline2DUnpack(c.GetInnerObj(), m, n, tbl);

  return;
}

static void CAlglib::Spline2DLinTransXY(CSpline2DInterpolantShell &c,
                                        const double ax, const double bx,
                                        const double ay, const double by) {

  CSpline2D::Spline2DLinTransXY(c.GetInnerObj(), ax, bx, ay, by);

  return;
}

static void CAlglib::Spline2DLinTransF(CSpline2DInterpolantShell &c,
                                       const double a, const double b) {

  CSpline2D::Spline2DLinTransF(c.GetInnerObj(), a, b);

  return;
}

static void CAlglib::Spline2DResampleBicubic(
    CMatrixDouble &a, const int oldheight, const int oldwidth, CMatrixDouble &b,
    const int newheight, const int newwidth) {

  CSpline2D::Spline2DResampleBicubic(a, oldheight, oldwidth, b, newheight,
                                     newwidth);

  return;
}

static void CAlglib::Spline2DResampleBilinear(
    CMatrixDouble &a, const int oldheight, const int oldwidth, CMatrixDouble &b,
    const int newheight, const int newwidth) {

  CSpline2D::Spline2DResampleBilinear(a, oldheight, oldwidth, b, newheight,
                                      newwidth);

  return;
}

static void CAlglib::CMatrixTranspose(const int m, const int n,
                                      CMatrixComplex &a, const int ia,
                                      const int ja, CMatrixComplex &b,
                                      const int ib, const int jb) {

  CAblas::CMatrixTranspose(m, n, a, ia, ja, b, ib, jb);

  return;
}

static void CAlglib::RMatrixTranspose(const int m, const int n,
                                      CMatrixDouble &a, const int ia,
                                      const int ja, CMatrixDouble &b,
                                      const int ib, const int jb) {

  CAblas::RMatrixTranspose(m, n, a, ia, ja, b, ib, jb);

  return;
}

static void CAlglib::CMatrixCopy(const int m, const int n, CMatrixComplex &a,
                                 const int ia, const int ja, CMatrixComplex &b,
                                 const int ib, const int jb) {

  CAblas::CMatrixCopy(m, n, a, ia, ja, b, ib, jb);

  return;
}

static void CAlglib::RMatrixCopy(const int m, const int n, CMatrixDouble &a,
                                 const int ia, const int ja, CMatrixDouble &b,
                                 const int ib, const int jb) {

  CAblas::RMatrixCopy(m, n, a, ia, ja, b, ib, jb);

  return;
}

static void CAlglib::CMatrixRank1(const int m, const int n, CMatrixComplex &a,
                                  const int ia, const int ja, al_complex &u[],
                                  const int iu, al_complex &v[], const int iv) {

  CAblas::CMatrixRank1(m, n, a, ia, ja, u, iu, v, iv);

  return;
}

static void CAlglib::RMatrixRank1(const int m, const int n, CMatrixDouble &a,
                                  const int ia, const int ja, double &u[],
                                  const int iu, double &v[], const int iv) {

  CAblas::RMatrixRank1(m, n, a, ia, ja, u, iu, v, iv);

  return;
}

static void CAlglib::CMatrixMVect(const int m, const int n, CMatrixComplex &a,
                                  const int ia, const int ja, const int opa,
                                  al_complex &x[], const int ix,
                                  al_complex &y[], const int iy) {

  CAblas::CMatrixMVect(m, n, a, ia, ja, opa, x, ix, y, iy);

  return;
}

static void CAlglib::RMatrixMVect(const int m, const int n, CMatrixDouble &a,
                                  const int ia, const int ja, const int opa,
                                  double &x[], const int ix, double &y[],
                                  const int iy) {

  CAblas::RMatrixMVect(m, n, a, ia, ja, opa, x, ix, y, iy);

  return;
}

static void CAlglib::CMatrixRightTrsM(const int m, const int n,
                                      CMatrixComplex &a, const int i1,
                                      const int j1, const bool isupper,
                                      const bool isunit, const int optype,
                                      CMatrixComplex &x, const int i2,
                                      const int j2) {

  CAblas::CMatrixRightTrsM(m, n, a, i1, j1, isupper, isunit, optype, x, i2, j2);

  return;
}

static void CAlglib::CMatrixLeftTrsM(const int m, const int n,
                                     CMatrixComplex &a, const int i1,
                                     const int j1, const bool isupper,
                                     const bool isunit, const int optype,
                                     CMatrixComplex &x, const int i2,
                                     const int j2) {

  CAblas::CMatrixLeftTrsM(m, n, a, i1, j1, isupper, isunit, optype, x, i2, j2);

  return;
}

static void CAlglib::RMatrixRightTrsM(const int m, const int n,
                                      CMatrixDouble &a, const int i1,
                                      const int j1, const bool isupper,
                                      const bool isunit, const int optype,
                                      CMatrixDouble &x, const int i2,
                                      const int j2) {

  CAblas::RMatrixRightTrsM(m, n, a, i1, j1, isupper, isunit, optype, x, i2, j2);

  return;
}

static void CAlglib::RMatrixLeftTrsM(const int m, const int n, CMatrixDouble &a,
                                     const int i1, const int j1,
                                     const bool isupper, const bool isunit,
                                     const int optype, CMatrixDouble &x,
                                     const int i2, const int j2) {

  CAblas::RMatrixLeftTrsM(m, n, a, i1, j1, isupper, isunit, optype, x, i2, j2);

  return;
}

static void CAlglib::CMatrixSyrk(const int n, const int k, const double alpha,
                                 CMatrixComplex &a, const int ia, const int ja,
                                 const int optypea, const double beta,
                                 CMatrixComplex &c, const int ic, const int jc,
                                 const bool isupper) {

  CAblas::CMatrixSyrk(n, k, alpha, a, ia, ja, optypea, beta, c, ic, jc,
                      isupper);

  return;
}

static void CAlglib::RMatrixSyrk(const int n, const int k, const double alpha,
                                 CMatrixDouble &a, const int ia, const int ja,
                                 const int optypea, const double beta,
                                 CMatrixDouble &c, const int ic, const int jc,
                                 const bool isupper) {

  CAblas::RMatrixSyrk(n, k, alpha, a, ia, ja, optypea, beta, c, ic, jc,
                      isupper);

  return;
}

static void CAlglib::CMatrixGemm(const int m, const int n, const int k,
                                 al_complex &alpha, CMatrixComplex &a,
                                 const int ia, const int ja, const int optypea,
                                 CMatrixComplex &b, const int ib, const int jb,
                                 const int optypeb, al_complex &beta,
                                 CMatrixComplex &c, const int ic,
                                 const int jc) {

  CAblas::CMatrixGemm(m, n, k, alpha, a, ia, ja, optypea, b, ib, jb, optypeb,
                      beta, c, ic, jc);

  return;
}

static void CAlglib::RMatrixGemm(const int m, const int n, const int k,
                                 const double alpha, CMatrixDouble &a,
                                 const int ia, const int ja, const int optypea,
                                 CMatrixDouble &b, const int ib, const int jb,
                                 const int optypeb, const double beta,
                                 CMatrixDouble &c, const int ic, const int jc) {

  CAblas::RMatrixGemm(m, n, k, alpha, a, ia, ja, optypea, b, ib, jb, optypeb,
                      beta, c, ic, jc);

  return;
}

static void CAlglib::RMatrixQR(CMatrixDouble &a, const int m, const int n,
                               double &tau[]) {

  COrtFac::RMatrixQR(a, m, n, tau);

  return;
}

static void CAlglib::RMatrixLQ(CMatrixDouble &a, const int m, const int n,
                               double &tau[]) {

  COrtFac::RMatrixLQ(a, m, n, tau);

  return;
}

static void CAlglib::CMatrixQR(CMatrixComplex &a, const int m, const int n,
                               al_complex &tau[]) {

  COrtFac::CMatrixQR(a, m, n, tau);

  return;
}

static void CAlglib::CMatrixLQ(CMatrixComplex &a, const int m, const int n,
                               al_complex &tau[]) {

  COrtFac::CMatrixLQ(a, m, n, tau);

  return;
}

static void CAlglib::RMatrixQRUnpackQ(CMatrixDouble &a, const int m,
                                      const int n, double &tau[],
                                      const int qcolumns, CMatrixDouble &q) {

  COrtFac::RMatrixQRUnpackQ(a, m, n, tau, qcolumns, q);

  return;
}

static void CAlglib::RMatrixQRUnpackR(CMatrixDouble &a, const int m,
                                      const int n, CMatrixDouble &r) {

  COrtFac::RMatrixQRUnpackR(a, m, n, r);

  return;
}

static void CAlglib::RMatrixLQUnpackQ(CMatrixDouble &a, const int m,
                                      const int n, double &tau[],
                                      const int qrows, CMatrixDouble &q) {

  COrtFac::RMatrixLQUnpackQ(a, m, n, tau, qrows, q);

  return;
}

static void CAlglib::RMatrixLQUnpackL(CMatrixDouble &a, const int m,
                                      const int n, CMatrixDouble &l) {

  COrtFac::RMatrixLQUnpackL(a, m, n, l);

  return;
}

static void CAlglib::CMatrixQRUnpackQ(CMatrixComplex &a, const int m,
                                      const int n, al_complex &tau[],
                                      const int qcolumns, CMatrixComplex &q) {

  COrtFac::CMatrixQRUnpackQ(a, m, n, tau, qcolumns, q);

  return;
}

static void CAlglib::CMatrixQRUnpackR(CMatrixComplex &a, const int m,
                                      const int n, CMatrixComplex &r) {

  COrtFac::CMatrixQRUnpackR(a, m, n, r);

  return;
}

static void CAlglib::CMatrixLQUnpackQ(CMatrixComplex &a, const int m,
                                      const int n, al_complex &tau[],
                                      const int qrows, CMatrixComplex &q) {

  COrtFac::CMatrixLQUnpackQ(a, m, n, tau, qrows, q);

  return;
}

static void CAlglib::CMatrixLQUnpackL(CMatrixComplex &a, const int m,
                                      const int n, CMatrixComplex &l) {

  COrtFac::CMatrixLQUnpackL(a, m, n, l);

  return;
}

static void CAlglib::RMatrixBD(CMatrixDouble &a, const int m, const int n,
                               double &tauq[], double &taup[]) {

  COrtFac::RMatrixBD(a, m, n, tauq, taup);

  return;
}

static void CAlglib::RMatrixBDUnpackQ(CMatrixDouble &qp, const int m,
                                      const int n, double &tauq[],
                                      const int qcolumns, CMatrixDouble &q) {

  COrtFac::RMatrixBDUnpackQ(qp, m, n, tauq, qcolumns, q);

  return;
}

static void CAlglib::RMatrixBDMultiplyByQ(CMatrixDouble &qp, const int m,
                                          const int n, double &tauq[],
                                          CMatrixDouble &z, const int zrows,
                                          const int zcolumns,
                                          const bool fromtheright,
                                          const bool dotranspose) {

  COrtFac::RMatrixBDMultiplyByQ(qp, m, n, tauq, z, zrows, zcolumns,
                                fromtheright, dotranspose);

  return;
}

static void CAlglib::RMatrixBDUnpackPT(CMatrixDouble &qp, const int m,
                                       const int n, double &taup[],
                                       const int ptrows, CMatrixDouble &pt) {

  COrtFac::RMatrixBDUnpackPT(qp, m, n, taup, ptrows, pt);

  return;
}

static void CAlglib::RMatrixBDMultiplyByP(CMatrixDouble &qp, const int m,
                                          const int n, double &taup[],
                                          CMatrixDouble &z, const int zrows,
                                          const int zcolumns,
                                          const bool fromtheright,
                                          const bool dotranspose) {

  COrtFac::RMatrixBDMultiplyByP(qp, m, n, taup, z, zrows, zcolumns,
                                fromtheright, dotranspose);

  return;
}

static void CAlglib::RMatrixBDUnpackDiagonals(CMatrixDouble &b, const int m,
                                              const int n, bool &isupper,
                                              double &d[], double &e[]) {

  isupper = false;

  COrtFac::RMatrixBDUnpackDiagonals(b, m, n, isupper, d, e);

  return;
}

static void CAlglib::RMatrixHessenberg(CMatrixDouble &a, const int n,
                                       double &tau[]) {

  COrtFac::RMatrixHessenberg(a, n, tau);

  return;
}

static void CAlglib::RMatrixHessenbergUnpackQ(CMatrixDouble &a, const int n,
                                              double &tau[], CMatrixDouble &q) {

  COrtFac::RMatrixHessenbergUnpackQ(a, n, tau, q);

  return;
}

static void CAlglib::RMatrixHessenbergUnpackH(CMatrixDouble &a, const int n,
                                              CMatrixDouble &h) {

  COrtFac::RMatrixHessenbergUnpackH(a, n, h);

  return;
}

static void CAlglib::SMatrixTD(CMatrixDouble &a, const int n,
                               const bool isupper, double &tau[], double &d[],
                               double &e[]) {

  COrtFac::SMatrixTD(a, n, isupper, tau, d, e);

  return;
}

static void CAlglib::SMatrixTDUnpackQ(CMatrixDouble &a, const int n,
                                      const bool isupper, double &tau[],
                                      CMatrixDouble &q) {

  COrtFac::SMatrixTDUnpackQ(a, n, isupper, tau, q);

  return;
}

static void CAlglib::HMatrixTD(CMatrixComplex &a, const int n,
                               const bool isupper, al_complex &tau[],
                               double &d[], double &e[]) {

  COrtFac::HMatrixTD(a, n, isupper, tau, d, e);

  return;
}

static void CAlglib::HMatrixTDUnpackQ(CMatrixComplex &a, const int n,
                                      const bool isupper, al_complex &tau[],
                                      CMatrixComplex &q) {

  COrtFac::HMatrixTDUnpackQ(a, n, isupper, tau, q);

  return;
}

static bool CAlglib::SMatrixEVD(CMatrixDouble &a, const int n, int zneeded,
                                const bool isupper, double &d[],
                                CMatrixDouble &z) {

  return (CEigenVDetect::SMatrixEVD(a, n, zneeded, isupper, d, z));
}

static bool CAlglib::SMatrixEVDR(CMatrixDouble &a, const int n, int zneeded,
                                 const bool isupper, double b1, double b2,
                                 int &m, double &w[], CMatrixDouble &z) {

  m = 0;

  return (CEigenVDetect::SMatrixEVDR(a, n, zneeded, isupper, b1, b2, m, w, z));
}

static bool CAlglib::SMatrixEVDI(CMatrixDouble &a, const int n, int zneeded,
                                 const bool isupper, const int i1, const int i2,
                                 double &w[], CMatrixDouble &z) {

  return (CEigenVDetect::SMatrixEVDI(a, n, zneeded, isupper, i1, i2, w, z));
}

static bool CAlglib::HMatrixEVD(CMatrixComplex &a, const int n,
                                const int zneeded, const bool isupper,
                                double &d[], CMatrixComplex &z) {

  return (CEigenVDetect::HMatrixEVD(a, n, zneeded, isupper, d, z));
}

static bool CAlglib::HMatrixEVDR(CMatrixComplex &a, const int n,
                                 const int zneeded, const bool isupper,
                                 double b1, double b2, int &m, double &w[],
                                 CMatrixComplex &z) {

  m = 0;

  return (CEigenVDetect::HMatrixEVDR(a, n, zneeded, isupper, b1, b2, m, w, z));
}

static bool CAlglib::HMatrixEVDI(CMatrixComplex &a, const int n,
                                 const int zneeded, const bool isupper,
                                 const int i1, const int i2, double &w[],
                                 CMatrixComplex &z) {

  return (CEigenVDetect::HMatrixEVDI(a, n, zneeded, isupper, i1, i2, w, z));
}

static bool CAlglib::SMatrixTdEVD(double &d[], double &e[], const int n,
                                  const int zneeded, CMatrixDouble &z) {

  return (CEigenVDetect::SMatrixTdEVD(d, e, n, zneeded, z));
}

static bool CAlglib::SMatrixTdEVDR(double &d[], double &e[], const int n,
                                   const int zneeded, const double a,
                                   const double b, int &m, CMatrixDouble &z) {

  m = 0;

  return (CEigenVDetect::SMatrixTdEVDR(d, e, n, zneeded, a, b, m, z));
}

static bool CAlglib::SMatrixTdEVDI(double &d[], double &e[], const int n,
                                   const int zneeded, const int i1,
                                   const int i2, CMatrixDouble &z) {

  return (CEigenVDetect::SMatrixTdEVDI(d, e, n, zneeded, i1, i2, z));
}

static bool CAlglib::RMatrixEVD(CMatrixDouble &a, const int n,
                                const int vneeded, double &wr[], double &wi[],
                                CMatrixDouble &vl, CMatrixDouble &vr) {
  bool result = CEigenVDetect::RMatrixEVD(a, n, vneeded, wr, wi, vl, vr);

  return (result);
}

static void CAlglib::RMatrixRndOrthogonal(const int n, CMatrixDouble &a) {

  CMatGen::RMatrixRndOrthogonal(n, a);

  return;
}

static void CAlglib::RMatrixRndCond(const int n, const double c,
                                    CMatrixDouble &a) {

  CMatGen::RMatrixRndCond(n, c, a);

  return;
}

static void CAlglib::CMatrixRndOrthogonal(const int n, CMatrixComplex &a) {

  CMatGen::CMatrixRndOrthogonal(n, a);

  return;
}

static void CAlglib::CMatrixRndCond(const int n, const double c,
                                    CMatrixComplex &a) {

  CMatGen::CMatrixRndCond(n, c, a);

  return;
}

static void CAlglib::SMatrixRndCond(const int n, const double c,
                                    CMatrixDouble &a) {

  CMatGen::SMatrixRndCond(n, c, a);

  return;
}

static void CAlglib::SPDMatrixRndCond(const int n, const double c,
                                      CMatrixDouble &a) {

  CMatGen::SPDMatrixRndCond(n, c, a);

  return;
}

static void CAlglib::HMatrixRndCond(const int n, const double c,
                                    CMatrixComplex &a) {

  CMatGen::HMatrixRndCond(n, c, a);

  return;
}

static void CAlglib::HPDMatrixRndCond(const int n, const double c,
                                      CMatrixComplex &a) {

  CMatGen::HPDMatrixRndCond(n, c, a);

  return;
}

static void CAlglib::RMatrixRndOrthogonalFromTheRight(CMatrixDouble &a,
                                                      const int m,
                                                      const int n) {

  CMatGen::RMatrixRndOrthogonalFromTheRight(a, m, n);

  return;
}

static void CAlglib::RMatrixRndOrthogonalFromTheLeft(CMatrixDouble &a,
                                                     const int m, const int n) {

  CMatGen::RMatrixRndOrthogonalFromTheLeft(a, m, n);

  return;
}

static void CAlglib::CMatrixRndOrthogonalFromTheRight(CMatrixComplex &a,
                                                      const int m,
                                                      const int n) {

  CMatGen::CMatrixRndOrthogonalFromTheRight(a, m, n);

  return;
}

static void CAlglib::CMatrixRndOrthogonalFromTheLeft(CMatrixComplex &a,
                                                     const int m, const int n) {

  CMatGen::CMatrixRndOrthogonalFromTheLeft(a, m, n);

  return;
}

static void CAlglib::SMatrixRndMultiply(CMatrixDouble &a, const int n) {

  CMatGen::SMatrixRndMultiply(a, n);

  return;
}

static void CAlglib::HMatrixRndMultiply(CMatrixComplex &a, const int n) {

  CMatGen::HMatrixRndMultiply(a, n);

  return;
}

static void CAlglib::RMatrixLU(CMatrixDouble &a, const int m, const int n,
                               int &pivots[]) {

  CTrFac::RMatrixLU(a, m, n, pivots);

  return;
}

static void CAlglib::CMatrixLU(CMatrixComplex &a, const int m, const int n,
                               int &pivots[]) {

  CTrFac::CMatrixLU(a, m, n, pivots);

  return;
}

static bool CAlglib::HPDMatrixCholesky(CMatrixComplex &a, const int n,
                                       const bool isupper) {

  return (CTrFac::HPDMatrixCholesky(a, n, isupper));
}

static bool CAlglib::SPDMatrixCholesky(CMatrixDouble &a, const int n,
                                       const bool isupper) {

  return (CTrFac::SPDMatrixCholesky(a, n, isupper));
}

static double CAlglib::RMatrixRCond1(CMatrixDouble &a, const int n) {

  return (CRCond::RMatrixRCond1(a, n));
}

static double CAlglib::RMatrixRCondInf(CMatrixDouble &a, const int n) {

  return (CRCond::RMatrixRCondInf(a, n));
}

static double CAlglib::SPDMatrixRCond(CMatrixDouble &a, const int n,
                                      const bool isupper) {

  return (CRCond::SPDMatrixRCond(a, n, isupper));
}

static double CAlglib::RMatrixTrRCond1(CMatrixDouble &a, const int n,
                                       const bool isupper, const bool isunit) {

  return (CRCond::RMatrixTrRCond1(a, n, isupper, isunit));
}

static double CAlglib::RMatrixTrRCondInf(CMatrixDouble &a, const int n,
                                         const bool isupper,
                                         const bool isunit) {

  return (CRCond::RMatrixTrRCondInf(a, n, isupper, isunit));
}

static double CAlglib::HPDMatrixRCond(CMatrixComplex &a, const int n,
                                      const bool isupper) {

  return (CRCond::HPDMatrixRCond(a, n, isupper));
}

static double CAlglib::CMatrixRCond1(CMatrixComplex &a, const int n) {

  return (CRCond::CMatrixRCond1(a, n));
}

static double CAlglib::CMatrixRCondInf(CMatrixComplex &a, const int n) {

  return (CRCond::CMatrixRCondInf(a, n));
}

static double CAlglib::RMatrixLURCond1(CMatrixDouble &lua, const int n) {

  return (CRCond::RMatrixLURCond1(lua, n));
}

static double CAlglib::RMatrixLURCondInf(CMatrixDouble &lua, const int n) {

  return (CRCond::RMatrixLURCondInf(lua, n));
}

static double CAlglib::SPDMatrixCholeskyRCond(CMatrixDouble &a, const int n,
                                              const bool isupper) {

  return (CRCond::SPDMatrixCholeskyRCond(a, n, isupper));
}

static double CAlglib::HPDMatrixCholeskyRCond(CMatrixComplex &a, const int n,
                                              const bool isupper) {

  return (CRCond::HPDMatrixCholeskyRCond(a, n, isupper));
}

static double CAlglib::CMatrixLURCond1(CMatrixComplex &lua, const int n) {

  return (CRCond::CMatrixLURCond1(lua, n));
}

static double CAlglib::CMatrixLURCondInf(CMatrixComplex &lua, const int n) {

  return (CRCond::CMatrixLURCondInf(lua, n));
}

static double CAlglib::CMatrixTrRCond1(CMatrixComplex &a, const int n,
                                       const bool isupper, const bool isunit) {

  return (CRCond::CMatrixTrRCond1(a, n, isupper, isunit));
}

static double CAlglib::CMatrixTrRCondInf(CMatrixComplex &a, const int n,
                                         const bool isupper,
                                         const bool isunit) {

  return (CRCond::CMatrixTrRCondInf(a, n, isupper, isunit));
}

static void CAlglib::RMatrixLUInverse(CMatrixDouble &a, int &pivots[],
                                      const int n, int &info,
                                      CMatInvReportShell &rep) {

  info = 0;

  CMatInv::RMatrixLUInverse(a, pivots, n, info, rep.GetInnerObj());

  return;
}

static void CAlglib::RMatrixLUInverse(CMatrixDouble &a, int &pivots[],
                                      int &info, CMatInvReportShell &rep) {

  int n;

  if ((CAp::Cols(a) != CAp::Rows(a)) || (CAp::Cols(a) != CAp::Len(pivots))) {
    Print(__FUNCTION__ + ": looks like one of arguments has wrong size");
    CAp::exception_happened = true;
    return;
  }

  info = 0;
  n = CAp::Cols(a);

  CMatInv::RMatrixLUInverse(a, pivots, n, info, rep.GetInnerObj());

  return;
}

static void CAlglib::RMatrixInverse(CMatrixDouble &a, const int n, int &info,
                                    CMatInvReportShell &rep) {

  info = 0;

  CMatInv::RMatrixInverse(a, n, info, rep.GetInnerObj());

  return;
}

static void CAlglib::RMatrixInverse(CMatrixDouble &a, int &info,
                                    CMatInvReportShell &rep) {

  int n;

  if ((CAp::Cols(a) != CAp::Rows(a))) {
    Print(__FUNCTION__ + ": looks like one of arguments has wrong size");
    CAp::exception_happened = true;
    return;
  }

  info = 0;
  n = CAp::Cols(a);

  CMatInv::RMatrixInverse(a, n, info, rep.GetInnerObj());

  return;
}

static void CAlglib::CMatrixLUInverse(CMatrixComplex &a, int &pivots[],
                                      const int n, int &info,
                                      CMatInvReportShell &rep) {

  info = 0;

  CMatInv::CMatrixLUInverse(a, pivots, n, info, rep.GetInnerObj());

  return;
}

static void CAlglib::CMatrixLUInverse(CMatrixComplex &a, int &pivots[],
                                      int &info, CMatInvReportShell &rep) {

  int n;

  if ((CAp::Cols(a) != CAp::Rows(a)) || (CAp::Cols(a) != CAp::Len(pivots))) {
    Print(__FUNCTION__ + ": looks like one of arguments has wrong size");
    CAp::exception_happened = true;
    return;
  }

  info = 0;
  n = CAp::Cols(a);

  CMatInv::CMatrixLUInverse(a, pivots, n, info, rep.GetInnerObj());

  return;
}

static void CAlglib::CMatrixInverse(CMatrixComplex &a, const int n, int &info,
                                    CMatInvReportShell &rep) {

  info = 0;

  CMatInv::CMatrixInverse(a, n, info, rep.GetInnerObj());

  return;
}

static void CAlglib::CMatrixInverse(CMatrixComplex &a, int &info,
                                    CMatInvReportShell &rep) {

  int n;

  if ((CAp::Cols(a) != CAp::Rows(a))) {
    Print(__FUNCTION__ + ": looks like one of arguments has wrong size");
    CAp::exception_happened = true;
    return;
  }

  info = 0;
  n = CAp::Cols(a);

  CMatInv::CMatrixInverse(a, n, info, rep.GetInnerObj());

  return;
}

static void CAlglib::SPDMatrixCholeskyInverse(CMatrixDouble &a, const int n,
                                              const bool isupper, int &info,
                                              CMatInvReportShell &rep) {

  info = 0;

  CMatInv::SPDMatrixCholeskyInverse(a, n, isupper, info, rep.GetInnerObj());

  return;
}

static void CAlglib::SPDMatrixCholeskyInverse(CMatrixDouble &a, int &info,
                                              CMatInvReportShell &rep) {

  int n;
  bool isupper;

  if ((CAp::Cols(a) != CAp::Rows(a))) {
    Print(__FUNCTION__ + ": looks like one of arguments has wrong size");
    CAp::exception_happened = true;
    return;
  }

  info = 0;
  n = CAp::Cols(a);

  isupper = false;

  CMatInv::SPDMatrixCholeskyInverse(a, n, isupper, info, rep.GetInnerObj());

  return;
}

static void CAlglib::SPDMatrixInverse(CMatrixDouble &a, const int n,
                                      const bool isupper, int &info,
                                      CMatInvReportShell &rep) {

  info = 0;

  CMatInv::SPDMatrixInverse(a, n, isupper, info, rep.GetInnerObj());

  return;
}

static void CAlglib::SPDMatrixInverse(CMatrixDouble &a, int &info,
                                      CMatInvReportShell &rep) {

  int n;
  bool isupper;

  if ((CAp::Cols(a) != CAp::Rows(a))) {
    Print(__FUNCTION__ + ": looks like one of arguments has wrong size");
    CAp::exception_happened = true;
    return;
  }

  if (!CAp::IsSymmetric(a)) {
    Print(__FUNCTION__ + ": 'a' parameter is not symmetric matrix");
    CAp::exception_happened = true;
    return;
  }

  info = 0;
  n = CAp::Cols(a);
  isupper = false;

  CMatInv::SPDMatrixInverse(a, n, isupper, info, rep.GetInnerObj());

  if (!CAp::ForceSymmetric(a)) {
    Print(__FUNCTION__ +
          ": Internal error while forcing symmetricity of 'a' parameter");
    CAp::exception_happened = true;
    return;
  }

  return;
}

static void CAlglib::HPDMatrixCholeskyInverse(CMatrixComplex &a, const int n,
                                              const bool isupper, int &info,
                                              CMatInvReportShell &rep) {

  info = 0;

  CMatInv::HPDMatrixCholeskyInverse(a, n, isupper, info, rep.GetInnerObj());

  return;
}

static void CAlglib::HPDMatrixCholeskyInverse(CMatrixComplex &a, int &info,
                                              CMatInvReportShell &rep) {

  int n;
  bool isupper;

  if ((CAp::Cols(a) != CAp::Rows(a))) {
    Print(__FUNCTION__ + ": looks like one of arguments has wrong size");
    CAp::exception_happened = true;
    return;
  }

  info = 0;
  n = CAp::Cols(a);
  isupper = false;

  CMatInv::HPDMatrixCholeskyInverse(a, n, isupper, info, rep.GetInnerObj());

  return;
}

static void CAlglib::HPDMatrixInverse(CMatrixComplex &a, const int n,
                                      const bool isupper, int &info,
                                      CMatInvReportShell &rep) {

  info = 0;

  CMatInv::HPDMatrixInverse(a, n, isupper, info, rep.GetInnerObj());

  return;
}

static void CAlglib::HPDMatrixInverse(CMatrixComplex &a, int &info,
                                      CMatInvReportShell &rep) {

  int n;
  bool isupper;

  if ((CAp::Cols(a) != CAp::Rows(a))) {
    Print(__FUNCTION__ + ": looks like one of arguments has wrong size");
    CAp::exception_happened = true;
    return;
  }

  if (!CAp::IsHermitian(a)) {
    Print(__FUNCTION__ + ": 'a' parameter is not Hermitian matrix");
    CAp::exception_happened = true;
    return;
  }

  info = 0;
  n = CAp::Cols(a);
  isupper = false;

  CMatInv::HPDMatrixInverse(a, n, isupper, info, rep.GetInnerObj());

  if (!CAp::ForceHermitian(a)) {
    Print(
        __FUNCTION__ +
        ": Internal error while forcing Hermitian properties of 'a' parameter");
    CAp::exception_happened = true;
    return;
  }

  return;
}

static void CAlglib::RMatrixTrInverse(CMatrixDouble &a, const int n,
                                      const bool isupper, const bool isunit,
                                      int &info, CMatInvReportShell &rep) {

  info = 0;

  CMatInv::RMatrixTrInverse(a, n, isupper, isunit, info, rep.GetInnerObj());

  return;
}

static void CAlglib::RMatrixTrInverse(CMatrixDouble &a, const bool isupper,
                                      int &info, CMatInvReportShell &rep) {

  int n;
  bool isunit;

  if ((CAp::Cols(a) != CAp::Rows(a))) {
    Print(__FUNCTION__ + ": looks like one of arguments has wrong size");
    CAp::exception_happened = true;
    return;
  }

  info = 0;
  n = CAp::Cols(a);
  isunit = false;

  CMatInv::RMatrixTrInverse(a, n, isupper, isunit, info, rep.GetInnerObj());

  return;
}

static void CAlglib::CMatrixTrInverse(CMatrixComplex &a, const int n,
                                      const bool isupper, const bool isunit,
                                      int &info, CMatInvReportShell &rep) {

  info = 0;

  CMatInv::CMatrixTrInverse(a, n, isupper, isunit, info, rep.GetInnerObj());

  return;
}

static void CAlglib::CMatrixTrInverse(CMatrixComplex &a, const bool isupper,
                                      int &info, CMatInvReportShell &rep) {

  int n;
  bool isunit;

  if ((CAp::Cols(a) != CAp::Rows(a))) {
    Print(__FUNCTION__ + ": looks like one of arguments has wrong size");
    CAp::exception_happened = true;
    return;
  }

  info = 0;
  n = CAp::Cols(a);
  isunit = false;

  CMatInv::CMatrixTrInverse(a, n, isupper, isunit, info, rep.GetInnerObj());

  return;
}

static bool CAlglib::RMatrixBdSVD(double &d[], double &e[], const int n,
                                  const bool isupper,
                                  bool isfractionalaccuracyrequired,
                                  CMatrixDouble &u, const int nru,
                                  CMatrixDouble &c, const int ncc,
                                  CMatrixDouble &vt, const int ncvt) {

  return (CBdSingValueDecompose::RMatrixBdSVD(d, e, n, isupper,
                                              isfractionalaccuracyrequired, u,
                                              nru, c, ncc, vt, ncvt));
}

static bool CAlglib::RMatrixSVD(CMatrixDouble &a, const int m, const int n,
                                const int uneeded, const int vtneeded,
                                const int additionalmemory, double &w[],
                                CMatrixDouble &u, CMatrixDouble &vt) {

  return (CSingValueDecompose::RMatrixSVD(a, m, n, uneeded, vtneeded,
                                          additionalmemory, w, u, vt));
}

static double CAlglib::RMatrixLUDet(CMatrixDouble &a, int &pivots[],
                                    const int n) {

  return (CMatDet::RMatrixLUDet(a, pivots, n));
}

static double CAlglib::RMatrixLUDet(CMatrixDouble &a, int &pivots[]) {

  int n;

  if ((CAp::Rows(a) != CAp::Cols(a)) || (CAp::Rows(a) != CAp::Len(pivots))) {
    Print(__FUNCTION__ + ": looks like one of arguments has wrong size");
    CAp::exception_happened = true;
    return (EMPTY_VALUE);
  }

  n = CAp::Rows(a);

  return (CMatDet::RMatrixLUDet(a, pivots, n));
}

static double CAlglib::RMatrixDet(CMatrixDouble &a, const int n) {

  return (CMatDet::RMatrixDet(a, n));
}

static double CAlglib::RMatrixDet(CMatrixDouble &a) {

  int n;

  if ((CAp::Rows(a) != CAp::Cols(a))) {
    Print(__FUNCTION__ + ": looks like one of arguments has wrong size");
    CAp::exception_happened = true;
    return (EMPTY_VALUE);
  }

  n = CAp::Rows(a);

  return (CMatDet::RMatrixDet(a, n));
}

static al_complex CAlglib::CMatrixLUDet(CMatrixComplex &a, int &pivots[],
                                        const int n) {

  return (CMatDet::CMatrixLUDet(a, pivots, n));
}

static al_complex CAlglib::CMatrixLUDet(CMatrixComplex &a, int &pivots[]) {

  int n;

  if ((CAp::Rows(a) != CAp::Cols(a)) || (CAp::Rows(a) != CAp::Len(pivots))) {
    Print(__FUNCTION__ + ": looks like one of arguments has wrong size");
    CAp::exception_happened = true;
    return (EMPTY_VALUE);
  }

  n = CAp::Rows(a);

  return (CMatDet::CMatrixLUDet(a, pivots, n));
}

static al_complex CAlglib::CMatrixDet(CMatrixComplex &a, const int n) {

  return (CMatDet::CMatrixDet(a, n));
}

static al_complex CAlglib::CMatrixDet(CMatrixComplex &a) {

  int n;

  if ((CAp::Rows(a) != CAp::Cols(a))) {
    Print(__FUNCTION__ + ": looks like one of arguments has wrong size");
    CAp::exception_happened = true;
    return (EMPTY_VALUE);
  }

  n = CAp::Rows(a);

  return (CMatDet::CMatrixDet(a, n));
}

static double CAlglib::SPDMatrixCholeskyDet(CMatrixDouble &a, const int n) {

  return (CMatDet::SPDMatrixCholeskyDet(a, n));
}

static double CAlglib::SPDMatrixCholeskyDet(CMatrixDouble &a) {

  int n;

  if ((CAp::Rows(a) != CAp::Cols(a))) {
    Print(__FUNCTION__ + ": looks like one of arguments has wrong size");
    CAp::exception_happened = true;
    return (EMPTY_VALUE);
  }

  n = CAp::Rows(a);

  return (CMatDet::SPDMatrixCholeskyDet(a, n));
}

static double CAlglib::SPDMatrixDet(CMatrixDouble &a, const int n,
                                    const bool isupper) {

  return (CMatDet::SPDMatrixDet(a, n, isupper));
}

static double CAlglib::SPDMatrixDet(CMatrixDouble &a) {

  int n;
  bool isupper;

  if ((CAp::Rows(a) != CAp::Cols(a))) {
    Print(__FUNCTION__ + ": looks like one of arguments has wrong size");
    CAp::exception_happened = true;
    return (EMPTY_VALUE);
  }

  if (!CAp::IsSymmetric(a)) {
    Print(__FUNCTION__ + ": 'a' parameter is not symmetric matrix");
    CAp::exception_happened = true;
    return (EMPTY_VALUE);
  }

  n = CAp::Rows(a);
  isupper = false;

  return (CMatDet::SPDMatrixDet(a, n, isupper));
}

static bool CAlglib::SMatrixGEVD(CMatrixDouble &a, const int n,
                                 const bool isuppera, CMatrixDouble &b,
                                 const bool isupperb, const int zneeded,
                                 const int problemtype, double &d[],
                                 CMatrixDouble &z) {

  return (CSpdGEVD::SMatrixGEVD(a, n, isuppera, b, isupperb, zneeded,
                                problemtype, d, z));
}

static bool CAlglib::SMatrixGEVDReduce(CMatrixDouble &a, const int n,
                                       const bool isuppera, CMatrixDouble &b,
                                       const bool isupperb,
                                       const int problemtype, CMatrixDouble &r,
                                       bool &isupperr) {

  isupperr = false;

  return (CSpdGEVD::SMatrixGEVDReduce(a, n, isuppera, b, isupperb, problemtype,
                                      r, isupperr));
}

static void CAlglib::RMatrixInvUpdateSimple(CMatrixDouble &inva, const int n,
                                            const int updrow,
                                            const int updcolumn,
                                            const double updval) {

  CInverseUpdate::RMatrixInvUpdateSimple(inva, n, updrow, updcolumn, updval);

  return;
}

static void CAlglib::RMatrixInvUpdateRow(CMatrixDouble &inva, const int n,
                                         const int updrow, double &v[]) {

  CInverseUpdate::RMatrixInvUpdateRow(inva, n, updrow, v);

  return;
}

static void CAlglib::RMatrixInvUpdateColumn(CMatrixDouble &inva, const int n,
                                            const int updcolumn, double &u[]) {

  CInverseUpdate::RMatrixInvUpdateColumn(inva, n, updcolumn, u);

  return;
}

static void CAlglib::RMatrixInvUpdateUV(CMatrixDouble &inva, const int n,
                                        double &u[], double &v[]) {

  CInverseUpdate::RMatrixInvUpdateUV(inva, n, u, v);

  return;
}

static bool CAlglib::RMatrixSchur(CMatrixDouble &a, const int n,
                                  CMatrixDouble &s) {

  return (CSchur::RMatrixSchur(a, n, s));
}

static void CAlglib::MinCGCreate(const int n, double &x[],
                                 CMinCGStateShell &state) {

  CMinCG::MinCGCreate(n, x, state.GetInnerObj());

  return;
}

static void CAlglib::MinCGCreate(double &x[], CMinCGStateShell &state) {

  int n;

  n = CAp::Len(x);

  CMinCG::MinCGCreate(n, x, state.GetInnerObj());

  return;
}

static void CAlglib::MinCGCreateF(const int n, double &x[], double diffstep,
                                  CMinCGStateShell &state) {

  CMinCG::MinCGCreateF(n, x, diffstep, state.GetInnerObj());

  return;
}

static void CAlglib::MinCGCreateF(double &x[], double diffstep,
                                  CMinCGStateShell &state) {

  int n;

  n = CAp::Len(x);

  CMinCG::MinCGCreateF(n, x, diffstep, state.GetInnerObj());

  return;
}

static void CAlglib::MinCGSetCond(CMinCGStateShell &state, double epsg,
                                  double epsf, double epsx, int maxits) {

  CMinCG::MinCGSetCond(state.GetInnerObj(), epsg, epsf, epsx, maxits);

  return;
}

static void CAlglib::MinCGSetScale(CMinCGStateShell &state, double &s[]) {

  CMinCG::MinCGSetScale(state.GetInnerObj(), s);

  return;
}

static void CAlglib::MinCGSetXRep(CMinCGStateShell &state, bool needxrep) {

  CMinCG::MinCGSetXRep(state.GetInnerObj(), needxrep);

  return;
}

static void CAlglib::MinCGSetCGType(CMinCGStateShell &state, int cgtype) {

  CMinCG::MinCGSetCGType(state.GetInnerObj(), cgtype);

  return;
}

static void CAlglib::MinCGSetStpMax(CMinCGStateShell &state, double stpmax) {

  CMinCG::MinCGSetStpMax(state.GetInnerObj(), stpmax);

  return;
}

static void CAlglib::MinCGSuggestStep(CMinCGStateShell &state, double stp) {

  CMinCG::MinCGSuggestStep(state.GetInnerObj(), stp);

  return;
}

static void CAlglib::MinCGSetPrecDefault(CMinCGStateShell &state) {

  CMinCG::MinCGSetPrecDefault(state.GetInnerObj());

  return;
}

static void CAlglib::MinCGSetPrecDiag(CMinCGStateShell &state, double &d[]) {

  CMinCG::MinCGSetPrecDiag(state.GetInnerObj(), d);

  return;
}

static void CAlglib::MinCGSetPrecScale(CMinCGStateShell &state) {

  CMinCG::MinCGSetPrecScale(state.GetInnerObj());

  return;
}

static bool CAlglib::MinCGIteration(CMinCGStateShell &state) {

  return (CMinCG::MinCGIteration(state.GetInnerObj()));
}

static void CAlglib::MinCGOptimize(CMinCGStateShell &state,
                                   CNDimensional_Func &func,
                                   CNDimensional_Rep &rep, bool rep_status,
                                   CObject &obj) {

  while (CAlglib::MinCGIteration(state)) {

    if (state.GetNeedF()) {
      func.Func(state.GetInnerObj().m_x, state.GetInnerObj().m_f, obj);

      continue;
    }

    if (state.GetInnerObj().m_xupdated) {

      if (rep_status)
        rep.Rep(state.GetInnerObj().m_x, state.GetInnerObj().m_f, obj);

      continue;
    }
    Print("ALGLIB: error in 'mincgoptimize' (some derivatives were not "
          "provided?)");
    CAp::exception_happened = true;
    return;
  }
}

static void CAlglib::MinCGOptimize(CMinCGStateShell &state,
                                   CNDimensional_Grad &grad,
                                   CNDimensional_Rep &rep, bool rep_status,
                                   CObject &obj) {

  while (CAlglib::MinCGIteration(state)) {

    if (state.GetNeedFG()) {
      grad.Grad(state.GetInnerObj().m_x, state.GetInnerObj().m_f,
                state.GetInnerObj().m_g, obj);

      continue;
    }

    if (state.GetInnerObj().m_xupdated) {

      if (rep_status)
        rep.Rep(state.GetInnerObj().m_x, state.GetInnerObj().m_f, obj);

      continue;
    }
    Print("ALGLIB: error in 'mincgoptimize' (some derivatives were not "
          "provided?)");
    CAp::exception_happened = true;
    return;
  }
}

static void CAlglib::MinCGResults(CMinCGStateShell &state, double &x[],
                                  CMinCGReportShell &rep) {

  CMinCG::MinCGResults(state.GetInnerObj(), x, rep.GetInnerObj());

  return;
}

static void CAlglib::MinCGResultsBuf(CMinCGStateShell &state, double &x[],
                                     CMinCGReportShell &rep) {

  CMinCG::MinCGResultsBuf(state.GetInnerObj(), x, rep.GetInnerObj());

  return;
}

static void CAlglib::MinCGRestartFrom(CMinCGStateShell &state, double &x[]) {

  CMinCG::MinCGRestartFrom(state.GetInnerObj(), x);

  return;
}

static void CAlglib::MinBLEICCreate(const int n, double &x[],
                                    CMinBLEICStateShell &state) {

  CMinBLEIC::MinBLEICCreate(n, x, state.GetInnerObj());

  return;
}

static void CAlglib::MinBLEICCreate(double &x[], CMinBLEICStateShell &state) {

  int n;

  n = CAp::Len(x);

  CMinBLEIC::MinBLEICCreate(n, x, state.GetInnerObj());

  return;
}

static void CAlglib::MinBLEICCreateF(const int n, double &x[], double diffstep,
                                     CMinBLEICStateShell &state) {

  CMinBLEIC::MinBLEICCreateF(n, x, diffstep, state.GetInnerObj());

  return;
}

static void CAlglib::MinBLEICCreateF(double &x[], double diffstep,
                                     CMinBLEICStateShell &state) {

  int n;

  n = CAp::Len(x);

  CMinBLEIC::MinBLEICCreateF(n, x, diffstep, state.GetInnerObj());

  return;
}

static void CAlglib::MinBLEICSetBC(CMinBLEICStateShell &state, double &bndl[],
                                   double &bndu[]) {

  CMinBLEIC::MinBLEICSetBC(state.GetInnerObj(), bndl, bndu);

  return;
}

static void CAlglib::MinBLEICSetLC(CMinBLEICStateShell &state, CMatrixDouble &c,
                                   int &ct[], const int k) {

  CMinBLEIC::MinBLEICSetLC(state.GetInnerObj(), c, ct, k);

  return;
}

static void CAlglib::MinBLEICSetLC(CMinBLEICStateShell &state, CMatrixDouble &c,
                                   int &ct[]) {

  int k;

  if (CAp::Rows(c) != CAp::Len(ct)) {
    Print(__FUNCTION__ + ": looks like one of arguments has wrong size");
    CAp::exception_happened = true;
    return;
  }

  k = CAp::Rows(c);

  CMinBLEIC::MinBLEICSetLC(state.GetInnerObj(), c, ct, k);

  return;
}

static void CAlglib::MinBLEICSetInnerCond(CMinBLEICStateShell &state,
                                          const double epsg, const double epsf,
                                          const double epsx) {

  CMinBLEIC::MinBLEICSetInnerCond(state.GetInnerObj(), epsg, epsf, epsx);

  return;
}

static void CAlglib::MinBLEICSetOuterCond(CMinBLEICStateShell &state,
                                          const double epsx,
                                          const double epsi) {

  CMinBLEIC::MinBLEICSetOuterCond(state.GetInnerObj(), epsx, epsi);

  return;
}

static void CAlglib::MinBLEICSetScale(CMinBLEICStateShell &state, double &s[]) {

  CMinBLEIC::MinBLEICSetScale(state.GetInnerObj(), s);

  return;
}

static void CAlglib::MinBLEICSetPrecDefault(CMinBLEICStateShell &state) {

  CMinBLEIC::MinBLEICSetPrecDefault(state.GetInnerObj());

  return;
}

static void CAlglib::MinBLEICSetPrecDiag(CMinBLEICStateShell &state,
                                         double &d[]) {

  CMinBLEIC::MinBLEICSetPrecDiag(state.GetInnerObj(), d);

  return;
}

static void CAlglib::MinBLEICSetPrecScale(CMinBLEICStateShell &state) {

  CMinBLEIC::MinBLEICSetPrecScale(state.GetInnerObj());

  return;
}

static void CAlglib::MinBLEICSetMaxIts(CMinBLEICStateShell &state,
                                       const int maxits) {

  CMinBLEIC::MinBLEICSetMaxIts(state.GetInnerObj(), maxits);

  return;
}

static void CAlglib::MinBLEICSetXRep(CMinBLEICStateShell &state,
                                     bool needxrep) {

  CMinBLEIC::MinBLEICSetXRep(state.GetInnerObj(), needxrep);

  return;
}

static void CAlglib::MinBLEICSetStpMax(CMinBLEICStateShell &state,
                                       double stpmax) {

  CMinBLEIC::MinBLEICSetStpMax(state.GetInnerObj(), stpmax);

  return;
}

static bool CAlglib::MinBLEICIteration(CMinBLEICStateShell &state) {

  return (CMinBLEIC::MinBLEICIteration(state.GetInnerObj()));
}

static void CAlglib::MinBLEICOptimize(CMinBLEICStateShell &state,
                                      CNDimensional_Func &func,
                                      CNDimensional_Rep &rep, bool rep_status,
                                      CObject &obj) {

  while (CAlglib::MinBLEICIteration(state)) {

    if (state.GetNeedF()) {
      func.Func(state.GetInnerObj().m_x, state.GetInnerObj().m_f, obj);

      continue;
    }

    if (state.GetInnerObj().m_xupdated) {

      if (rep_status)
        rep.Rep(state.GetInnerObj().m_x, state.GetInnerObj().m_f, obj);

      continue;
    }
    Print("ALGLIB: error in 'minbleicoptimize' (some derivatives were not "
          "provided?)");
    CAp::exception_happened = true;
    return;
  }
}

static void CAlglib::MinBLEICOptimize(CMinBLEICStateShell &state,
                                      CNDimensional_Grad &grad,
                                      CNDimensional_Rep &rep, bool rep_status,
                                      CObject &obj) {

  while (CAlglib::MinBLEICIteration(state)) {

    if (state.GetNeedFG()) {
      grad.Grad(state.GetInnerObj().m_x, state.GetInnerObj().m_f,
                state.GetInnerObj().m_g, obj);

      continue;
    }

    if (state.GetInnerObj().m_xupdated) {

      if (rep_status)
        rep.Rep(state.GetInnerObj().m_x, state.GetInnerObj().m_f, obj);

      continue;
    }
    Print("ALGLIB: error in 'minbleicoptimize' (some derivatives were not "
          "provided?)");
    CAp::exception_happened = true;
    return;
  }
}

static void CAlglib::MinBLEICResults(CMinBLEICStateShell &state, double &x[],
                                     CMinBLEICReportShell &rep) {

  CMinBLEIC::MinBLEICResults(state.GetInnerObj(), x, rep.GetInnerObj());

  return;
}

static void CAlglib::MinBLEICResultsBuf(CMinBLEICStateShell &state, double &x[],
                                        CMinBLEICReportShell &rep) {

  CMinBLEIC::MinBLEICResultsBuf(state.GetInnerObj(), x, rep.GetInnerObj());

  return;
}

static void CAlglib::MinBLEICRestartFrom(CMinBLEICStateShell &state,
                                         double &x[]) {

  CMinBLEIC::MinBLEICRestartFrom(state.GetInnerObj(), x);

  return;
}

static void CAlglib::MinLBFGSCreate(const int n, const int m, double &x[],
                                    CMinLBFGSStateShell &state) {

  CMinLBFGS::MinLBFGSCreate(n, m, x, state.GetInnerObj());

  return;
}

static void CAlglib::MinLBFGSCreate(const int m, double &x[],
                                    CMinLBFGSStateShell &state) {

  int n;

  n = CAp::Len(x);

  CMinLBFGS::MinLBFGSCreate(n, m, x, state.GetInnerObj());

  return;
}

static void CAlglib::MinLBFGSCreateF(const int n, const int m, double &x[],
                                     const double diffstep,
                                     CMinLBFGSStateShell &state) {

  CMinLBFGS::MinLBFGSCreateF(n, m, x, diffstep, state.GetInnerObj());

  return;
}

static void CAlglib::MinLBFGSCreateF(const int m, double &x[],
                                     const double diffstep,
                                     CMinLBFGSStateShell &state) {

  int n;

  n = CAp::Len(x);

  CMinLBFGS::MinLBFGSCreateF(n, m, x, diffstep, state.GetInnerObj());

  return;
}

static void CAlglib::MinLBFGSSetCond(CMinLBFGSStateShell &state,
                                     const double epsg, const double epsf,
                                     const double epsx, const int maxits) {

  CMinLBFGS::MinLBFGSSetCond(state.GetInnerObj(), epsg, epsf, epsx, maxits);

  return;
}

static void CAlglib::MinLBFGSSetXRep(CMinLBFGSStateShell &state,
                                     const bool needxrep) {

  CMinLBFGS::MinLBFGSSetXRep(state.GetInnerObj(), needxrep);

  return;
}

static void CAlglib::MinLBFGSSetStpMax(CMinLBFGSStateShell &state,
                                       const double stpmax) {

  CMinLBFGS::MinLBFGSSetStpMax(state.GetInnerObj(), stpmax);

  return;
}

static void CAlglib::MinLBFGSSetScale(CMinLBFGSStateShell &state, double &s[]) {

  CMinLBFGS::MinLBFGSSetScale(state.GetInnerObj(), s);

  return;
}

static void CAlglib::MinLBFGSSetPrecDefault(CMinLBFGSStateShell &state) {

  CMinLBFGS::MinLBFGSSetPrecDefault(state.GetInnerObj());

  return;
}

static void CAlglib::MinLBFGSSetPrecCholesky(CMinLBFGSStateShell &state,
                                             CMatrixDouble &p,
                                             const bool isupper) {

  CMinLBFGS::MinLBFGSSetPrecCholesky(state.GetInnerObj(), p, isupper);

  return;
}

static void CAlglib::MinLBFGSSetPrecDiag(CMinLBFGSStateShell &state,
                                         double &d[]) {

  CMinLBFGS::MinLBFGSSetPrecDiag(state.GetInnerObj(), d);

  return;
}

static void CAlglib::MinLBFGSSetPrecScale(CMinLBFGSStateShell &state) {

  CMinLBFGS::MinLBFGSSetPrecScale(state.GetInnerObj());

  return;
}

static bool CAlglib::MinLBFGSIteration(CMinLBFGSStateShell &state) {

  return (CMinLBFGS::MinLBFGSIteration(state.GetInnerObj()));
}

static void CAlglib::MinLBFGSOptimize(CMinLBFGSStateShell &state,
                                      CNDimensional_Func &func,
                                      CNDimensional_Rep &rep, bool rep_status,
                                      CObject &obj) {

  while (CAlglib::MinLBFGSIteration(state)) {

    if (state.GetNeedF()) {
      func.Func(state.GetInnerObj().m_x, state.GetInnerObj().m_f, obj);

      continue;
    }

    if (state.GetInnerObj().m_xupdated) {

      if (rep_status)
        rep.Rep(state.GetInnerObj().m_x, state.GetInnerObj().m_f, obj);

      continue;
    }
    Print("ALGLIB: error in 'minlbfgsoptimize' (some derivatives were not "
          "provided?)");
    CAp::exception_happened = true;
    return;
  }
}

static void CAlglib::MinLBFGSOptimize(CMinLBFGSStateShell &state,
                                      CNDimensional_Grad &grad,
                                      CNDimensional_Rep &rep, bool rep_status,
                                      CObject &obj) {

  while (CAlglib::MinLBFGSIteration(state)) {

    if (state.GetNeedFG()) {
      grad.Grad(state.GetInnerObj().m_x, state.GetInnerObj().m_f,
                state.GetInnerObj().m_g, obj);

      continue;
    }

    if (state.GetInnerObj().m_xupdated) {

      if (rep_status)
        rep.Rep(state.GetInnerObj().m_x, state.GetInnerObj().m_f, obj);

      continue;
    }
    Print("ALGLIB: error in 'minlbfgsoptimize' (some derivatives were not "
          "provided?)");
    CAp::exception_happened = true;
    return;
  }
}

static void CAlglib::MinLBFGSResults(CMinLBFGSStateShell &state, double &x[],
                                     CMinLBFGSReportShell &rep) {

  CMinLBFGS::MinLBFGSResults(state.GetInnerObj(), x, rep.GetInnerObj());

  return;
}

static void CAlglib::MinLBFGSresultsbuf(CMinLBFGSStateShell &state, double &x[],
                                        CMinLBFGSReportShell &rep) {

  CMinLBFGS::MinLBFGSresultsbuf(state.GetInnerObj(), x, rep.GetInnerObj());

  return;
}

static void CAlglib::MinLBFGSRestartFrom(CMinLBFGSStateShell &state,
                                         double &x[]) {

  CMinLBFGS::MinLBFGSRestartFrom(state.GetInnerObj(), x);

  return;
}

static void CAlglib::MinQPCreate(const int n, CMinQPStateShell &state) {

  CMinQP::MinQPCreate(n, state.GetInnerObj());

  return;
}

static void CAlglib::MinQPSetLinearTerm(CMinQPStateShell &state, double &b[]) {

  CMinQP::MinQPSetLinearTerm(state.GetInnerObj(), b);

  return;
}

static void CAlglib::MinQPSetQuadraticTerm(CMinQPStateShell &state,
                                           CMatrixDouble &a,
                                           const bool isupper) {

  CMinQP::MinQPSetQuadraticTerm(state.GetInnerObj(), a, isupper);

  return;
}

static void CAlglib::MinQPSetQuadraticTerm(CMinQPStateShell &state,
                                           CMatrixDouble &a) {

  bool isupper;

  if (!CAp::IsSymmetric(a)) {
    Print(__FUNCTION__ + ": 'a' parameter is not symmetric matrix");
    CAp::exception_happened = true;
    return;
  }

  isupper = false;

  CMinQP::MinQPSetQuadraticTerm(state.GetInnerObj(), a, isupper);

  return;
}

static void CAlglib::MinQPSetStartingPoint(CMinQPStateShell &state,
                                           double &x[]) {

  CMinQP::MinQPSetStartingPoint(state.GetInnerObj(), x);

  return;
}

static void CAlglib::MinQPSetOrigin(CMinQPStateShell &state,
                                    double &xorigin[]) {

  CMinQP::MinQPSetOrigin(state.GetInnerObj(), xorigin);

  return;
}

static void CAlglib::MinQPSetAlgoCholesky(CMinQPStateShell &state) {

  CMinQP::MinQPSetAlgoCholesky(state.GetInnerObj());

  return;
}

static void CAlglib::MinQPSetBC(CMinQPStateShell &state, double &bndl[],
                                double &bndu[]) {

  CMinQP::MinQPSetBC(state.GetInnerObj(), bndl, bndu);

  return;
}

static void CAlglib::MinQPOptimize(CMinQPStateShell &state) {

  CMinQP::MinQPOptimize(state.GetInnerObj());

  return;
}

static void CAlglib::MinQPResults(CMinQPStateShell &state, double &x[],
                                  CMinQPReportShell &rep) {

  CMinQP::MinQPResults(state.GetInnerObj(), x, rep.GetInnerObj());

  return;
}

static void CAlglib::MinQPResultsBuf(CMinQPStateShell &state, double &x[],
                                     CMinQPReportShell &rep) {

  CMinQP::MinQPResultsBuf(state.GetInnerObj(), x, rep.GetInnerObj());

  return;
}

static void CAlglib::MinLMCreateVJ(const int n, const int m, double &x[],
                                   CMinLMStateShell &state) {

  CMinLM::MinLMCreateVJ(n, m, x, state.GetInnerObj());

  return;
}

static void CAlglib::MinLMCreateVJ(const int m, double &x[],
                                   CMinLMStateShell &state) {

  int n;

  n = CAp::Len(x);

  CMinLM::MinLMCreateVJ(n, m, x, state.GetInnerObj());

  return;
}

static void CAlglib::MinLMCreateV(const int n, const int m, double &x[],
                                  double diffstep, CMinLMStateShell &state) {

  CMinLM::MinLMCreateV(n, m, x, diffstep, state.GetInnerObj());

  return;
}

static void CAlglib::MinLMCreateV(const int m, double &x[],
                                  const double diffstep,
                                  CMinLMStateShell &state) {

  int n;

  n = CAp::Len(x);

  CMinLM::MinLMCreateV(n, m, x, diffstep, state.GetInnerObj());

  return;
}

static void CAlglib::MinLMCreateFGH(const int n, double &x[],
                                    CMinLMStateShell &state) {

  CMinLM::MinLMCreateFGH(n, x, state.GetInnerObj());

  return;
}

static void CAlglib::MinLMCreateFGH(double &x[], CMinLMStateShell &state) {

  int n;

  n = CAp::Len(x);

  CMinLM::MinLMCreateFGH(n, x, state.GetInnerObj());

  return;
}

static void CAlglib::MinLMSetCond(CMinLMStateShell &state, const double epsg,
                                  const double epsf, const double epsx,
                                  const int maxits) {

  CMinLM::MinLMSetCond(state.GetInnerObj(), epsg, epsf, epsx, maxits);

  return;
}

static void CAlglib::MinLMSetXRep(CMinLMStateShell &state,
                                  const bool needxrep) {

  CMinLM::MinLMSetXRep(state.GetInnerObj(), needxrep);

  return;
}

static void CAlglib::MinLMSetStpMax(CMinLMStateShell &state,
                                    const double stpmax) {

  CMinLM::MinLMSetStpMax(state.GetInnerObj(), stpmax);

  return;
}

static void CAlglib::MinLMSetScale(CMinLMStateShell &state, double &s[]) {

  CMinLM::MinLMSetScale(state.GetInnerObj(), s);

  return;
}

static void CAlglib::MinLMSetBC(CMinLMStateShell &state, double &bndl[],
                                double &bndu[]) {

  CMinLM::MinLMSetBC(state.GetInnerObj(), bndl, bndu);

  return;
}

static void CAlglib::MinLMSetAccType(CMinLMStateShell &state,
                                     const int acctype) {

  CMinLM::MinLMSetAccType(state.GetInnerObj(), acctype);

  return;
}

static bool CAlglib::MinLMIteration(CMinLMStateShell &state) {

  return (CMinLM::MinLMIteration(state.GetInnerObj()));
}

static void CAlglib::MinLMOptimize(CMinLMStateShell &state,
                                   CNDimensional_FVec &fvec,
                                   CNDimensional_Rep &rep, bool rep_status,
                                   CObject &obj) {

  while (CAlglib::MinLMIteration(state)) {
    if (state.GetNeedFI()) {
      fvec.FVec(state.GetInnerObj().m_x, state.GetInnerObj().m_fi, obj);

      continue;
    }

    if (state.GetInnerObj().m_xupdated) {

      if (rep_status)
        rep.Rep(state.GetInnerObj().m_x, state.GetInnerObj().m_f, obj);

      continue;
    }
    Print("ALGLIB: error in 'minlmoptimize' (some derivatives were not "
          "provided?)");
    CAp::exception_happened = true;
    return;
  }
}

static void CAlglib::MinLMOptimize(CMinLMStateShell &state,
                                   CNDimensional_FVec &fvec,
                                   CNDimensional_Jac &jac,
                                   CNDimensional_Rep &rep, bool rep_status,
                                   CObject &obj) {

  while (CAlglib::MinLMIteration(state)) {

    if (state.GetNeedFI()) {
      fvec.FVec(state.GetInnerObj().m_x, state.GetInnerObj().m_fi, obj);

      continue;
    }

    if (state.GetNeedFIJ()) {
      jac.Jac(state.GetInnerObj().m_x, state.GetInnerObj().m_fi,
              state.GetInnerObj().m_j, obj);

      continue;
    }

    if (state.GetInnerObj().m_xupdated) {

      if (rep_status)
        rep.Rep(state.GetInnerObj().m_x, state.GetInnerObj().m_f, obj);

      continue;
    }
    Print("ALGLIB: error in 'minlmoptimize' (some derivatives were not "
          "provided?)");
    CAp::exception_happened = true;
    return;
  }
}

static void CAlglib::MinLMOptimize(CMinLMStateShell &state,
                                   CNDimensional_Func &func,
                                   CNDimensional_Grad &grad,
                                   CNDimensional_Hess &hess,
                                   CNDimensional_Rep &rep, bool rep_status,
                                   CObject &obj) {

  while (CAlglib::MinLMIteration(state)) {

    if (state.GetNeedF()) {
      func.Func(state.GetInnerObj().m_x, state.GetInnerObj().m_f, obj);

      continue;
    }

    if (state.GetNeedFG()) {
      grad.Grad(state.GetInnerObj().m_x, state.GetInnerObj().m_f,
                state.GetInnerObj().m_g, obj);

      continue;
    }

    if (state.GetNeedFGH()) {
      hess.Hess(state.GetInnerObj().m_x, state.GetInnerObj().m_f,
                state.GetInnerObj().m_g, state.GetInnerObj().m_h, obj);

      continue;
    }

    if (state.GetInnerObj().m_xupdated) {

      if (rep_status)
        rep.Rep(state.GetInnerObj().m_x, state.GetInnerObj().m_f, obj);

      continue;
    }
    Print("ALGLIB: error in 'minlmoptimize' (some derivatives were not "
          "provided?)");
    CAp::exception_happened = true;
    return;
  }
}

static void CAlglib::MinLMOptimize(CMinLMStateShell &state,
                                   CNDimensional_Func &func,
                                   CNDimensional_Jac &jac,
                                   CNDimensional_Rep &rep, bool rep_status,
                                   CObject &obj) {

  while (CAlglib::MinLMIteration(state)) {

    if (state.GetNeedF()) {
      func.Func(state.GetInnerObj().m_x, state.GetInnerObj().m_f, obj);

      continue;
    }

    if (state.GetNeedFIJ()) {
      jac.Jac(state.GetInnerObj().m_x, state.GetInnerObj().m_fi,
              state.GetInnerObj().m_j, obj);

      continue;
    }

    if (state.GetInnerObj().m_xupdated) {

      if (rep_status)
        rep.Rep(state.GetInnerObj().m_x, state.GetInnerObj().m_f, obj);

      continue;
    }
    Print("ALGLIB: error in 'minlmoptimize' (some derivatives were not "
          "provided?)");
    CAp::exception_happened = true;
    return;
  }
}

static void CAlglib::MinLMOptimize(CMinLMStateShell &state,
                                   CNDimensional_Func &func,
                                   CNDimensional_Grad &grad,
                                   CNDimensional_Jac &jac,
                                   CNDimensional_Rep &rep, bool rep_status,
                                   CObject &obj) {

  while (CAlglib::MinLMIteration(state)) {

    if (state.GetNeedF()) {
      func.Func(state.GetInnerObj().m_x, state.GetInnerObj().m_f, obj);

      continue;
    }

    if (state.GetNeedFG()) {
      grad.Grad(state.GetInnerObj().m_x, state.GetInnerObj().m_f,
                state.GetInnerObj().m_g, obj);

      continue;
    }

    if (state.GetNeedFIJ()) {
      jac.Jac(state.GetInnerObj().m_x, state.GetInnerObj().m_fi,
              state.GetInnerObj().m_j, obj);

      continue;
    }

    if (state.GetInnerObj().m_xupdated) {

      if (rep_status)
        rep.Rep(state.GetInnerObj().m_x, state.GetInnerObj().m_f, obj);

      continue;
    }
    Print("ALGLIB: error in 'minlmoptimize' (some derivatives were not "
          "provided?)");
    CAp::exception_happened = true;
    return;
  }
}

static void CAlglib::MinLMResults(CMinLMStateShell &state, double &x[],
                                  CMinLMReportShell &rep) {

  CMinLM::MinLMResults(state.GetInnerObj(), x, rep.GetInnerObj());

  return;
}

static void CAlglib::MinLMResultsBuf(CMinLMStateShell &state, double &x[],
                                     CMinLMReportShell &rep) {

  CMinLM::MinLMResultsBuf(state.GetInnerObj(), x, rep.GetInnerObj());

  return;
}

static void CAlglib::MinLMRestartFrom(CMinLMStateShell &state, double &x[]) {

  CMinLM::MinLMRestartFrom(state.GetInnerObj(), x);

  return;
}

static void CAlglib::MinLMCreateVGJ(const int n, const int m, double &x[],
                                    CMinLMStateShell &state) {

  CMinLM::MinLMCreateVGJ(n, m, x, state.GetInnerObj());

  return;
}

static void CAlglib::MinLMCreateVGJ(const int m, double &x[],
                                    CMinLMStateShell &state) {

  int n;

  n = CAp::Len(x);

  CMinLM::MinLMCreateVGJ(n, m, x, state.GetInnerObj());

  return;
}

static void CAlglib::MinLMCreateFGJ(const int n, const int m, double &x[],
                                    CMinLMStateShell &state) {

  CMinLM::MinLMCreateFGJ(n, m, x, state.GetInnerObj());

  return;
}

static void CAlglib::MinLMCreateFGJ(const int m, double &x[],
                                    CMinLMStateShell &state) {

  int n;

  n = CAp::Len(x);

  CMinLM::MinLMCreateFGJ(n, m, x, state.GetInnerObj());

  return;
}

static void CAlglib::MinLMCreateFJ(const int n, const int m, double &x[],
                                   CMinLMStateShell &state) {

  CMinLM::MinLMCreateFJ(n, m, x, state.GetInnerObj());

  return;
}

static void CAlglib::MinLMCreateFJ(const int m, double &x[],
                                   CMinLMStateShell &state) {

  int n;

  n = CAp::Len(x);

  CMinLM::MinLMCreateFJ(n, m, x, state.GetInnerObj());

  return;
}

static void CAlglib::MinLBFGSSetDefaultPreconditioner(
    CMinLBFGSStateShell &state) {

  CMinComp::MinLBFGSSetDefaultPreconditioner(state.GetInnerObj());

  return;
}

static void CAlglib::MinLBFGSSetCholeskyPreconditioner(
    CMinLBFGSStateShell &state, CMatrixDouble &p, bool isupper) {

  CMinComp::MinLBFGSSetCholeskyPreconditioner(state.GetInnerObj(), p, isupper);

  return;
}

static void CAlglib::MinBLEICSetBarrierWidth(CMinBLEICStateShell &state,
                                             const double mu) {

  CMinComp::MinBLEICSetBarrierWidth(state.GetInnerObj(), mu);

  return;
}

static void CAlglib::MinBLEICSetBarrierDecay(CMinBLEICStateShell &state,
                                             const double mudecay) {

  CMinComp::MinBLEICSetBarrierDecay(state.GetInnerObj(), mudecay);

  return;
}

static void CAlglib::MinASACreate(const int n, double &x[], double &bndl[],
                                  double &bndu[], CMinASAStateShell &state) {

  CMinComp::MinASACreate(n, x, bndl, bndu, state.GetInnerObj());

  return;
}

static void CAlglib::MinASACreate(double &x[], double &bndl[], double &bndu[],
                                  CMinASAStateShell &state) {

  int n;

  if ((CAp::Len(x) != CAp::Len(bndl)) || (CAp::Len(x) != CAp::Len(bndu))) {
    Print("Error while calling 'minasacreate': looks like one of arguments has "
          "wrong size");
    CAp::exception_happened = true;
    return;
  }

  n = CAp::Len(x);

  CMinComp::MinASACreate(n, x, bndl, bndu, state.GetInnerObj());

  return;
}

static void CAlglib::MinASASetCond(CMinASAStateShell &state, const double epsg,
                                   const double epsf, const double epsx,
                                   const int maxits) {

  CMinComp::MinASASetCond(state.GetInnerObj(), epsg, epsf, epsx, maxits);

  return;
}

static void CAlglib::MinASASetXRep(CMinASAStateShell &state,
                                   const bool needxrep) {

  CMinComp::MinASASetXRep(state.GetInnerObj(), needxrep);

  return;
}

static void CAlglib::MinASASetAlgorithm(CMinASAStateShell &state,
                                        const int algotype) {

  CMinComp::MinASASetAlgorithm(state.GetInnerObj(), algotype);

  return;
}

static void CAlglib::MinASASetStpMax(CMinASAStateShell &state,
                                     const double stpmax) {

  CMinComp::MinASASetStpMax(state.GetInnerObj(), stpmax);

  return;
}

static bool CAlglib::MinASAIteration(CMinASAStateShell &state) {

  return (CMinComp::MinASAIteration(state.GetInnerObj()));
}

static void CAlglib::MinASAOptimize(CMinASAStateShell &state,
                                    CNDimensional_Grad &grad,
                                    CNDimensional_Rep &rep, bool rep_status,
                                    CObject &obj) {

  while (CAlglib::MinASAIteration(state)) {

    if (state.GetNeedFG()) {
      grad.Grad(state.GetInnerObj().m_x, state.GetInnerObj().m_f,
                state.GetInnerObj().m_g, obj);

      continue;
    }

    if (state.GetInnerObj().m_xupdated) {

      if (rep_status)
        rep.Rep(state.GetInnerObj().m_x, state.GetInnerObj().m_f, obj);

      continue;
    }
    Print("ALGLIB: error in 'minasaoptimize' (some derivatives were not "
          "provided?)");
    CAp::exception_happened = true;
    return;
  }
}

static void CAlglib::MinASAResults(CMinASAStateShell &state, double &x[],
                                   CMinASAReportShell &rep) {

  CMinComp::MinASAResults(state.GetInnerObj(), x, rep.GetInnerObj());

  return;
}

static void CAlglib::MinASAResultsBuf(CMinASAStateShell &state, double &x[],
                                      CMinASAReportShell &rep) {

  CMinComp::MinASAResultsBuf(state.GetInnerObj(), x, rep.GetInnerObj());

  return;
}

static void CAlglib::MinASARestartFrom(CMinASAStateShell &state, double &x[],
                                       double &bndl[], double &bndu[]) {

  CMinComp::MinASARestartFrom(state.GetInnerObj(), x, bndl, bndu);

  return;
}

static void CAlglib::RMatrixSolve(CMatrixDouble &a, const int n, double &b[],
                                  int &info, CDenseSolverReportShell &rep,
                                  double &x[]) {

  info = 0;

  CDenseSolver::RMatrixSolve(a, n, b, info, rep.GetInnerObj(), x);

  return;
}

static void CAlglib::RMatrixSolveM(CMatrixDouble &a, const int n,
                                   CMatrixDouble &b, const int m,
                                   const bool rfs, int &info,
                                   CDenseSolverReportShell &rep,
                                   CMatrixDouble &x) {

  info = 0;

  CDenseSolver::RMatrixSolveM(a, n, b, m, rfs, info, rep.GetInnerObj(), x);

  return;
}

static void CAlglib::RMatrixLUSolve(CMatrixDouble &lua, int &p[], const int n,
                                    double &b[], int &info,
                                    CDenseSolverReportShell &rep, double &x[]) {
  info = 0;

  CDenseSolver::RMatrixLUSolve(lua, p, n, b, info, rep.GetInnerObj(), x);

  return;
}

static void CAlglib::RMatrixLUSolveM(CMatrixDouble &lua, int &p[], const int n,
                                     CMatrixDouble &b, const int m, int &info,
                                     CDenseSolverReportShell &rep,
                                     CMatrixDouble &x) {

  info = 0;

  CDenseSolver::RMatrixLUSolveM(lua, p, n, b, m, info, rep.GetInnerObj(), x);

  return;
}

static void CAlglib::RMatrixMixedSolve(CMatrixDouble &a, CMatrixDouble &lua,
                                       int &p[], const int n, double &b[],
                                       int &info, CDenseSolverReportShell &rep,
                                       double &x[]) {

  info = 0;

  CDenseSolver::RMatrixMixedSolve(a, lua, p, n, b, info, rep.GetInnerObj(), x);

  return;
}

static void CAlglib::RMatrixMixedSolveM(CMatrixDouble &a, CMatrixDouble &lua,
                                        int &p[], const int n, CMatrixDouble &b,
                                        const int m, int &info,
                                        CDenseSolverReportShell &rep,
                                        CMatrixDouble &x) {

  info = 0;

  CDenseSolver::RMatrixMixedSolveM(a, lua, p, n, b, m, info, rep.GetInnerObj(),
                                   x);

  return;
}

static void CAlglib::CMatrixSolveM(CMatrixComplex &a, const int n,
                                   CMatrixComplex &b, const int m,
                                   const bool rfs, int &info,
                                   CDenseSolverReportShell &rep,
                                   CMatrixComplex &x) {

  info = 0;

  CDenseSolver::CMatrixSolveM(a, n, b, m, rfs, info, rep.GetInnerObj(), x);

  return;
}

static void CAlglib::CMatrixSolve(CMatrixComplex &a, const int n,
                                  al_complex &b[], int &info,
                                  CDenseSolverReportShell &rep,
                                  al_complex &x[]) {

  info = 0;

  CDenseSolver::CMatrixSolve(a, n, b, info, rep.GetInnerObj(), x);

  return;
}

static void CAlglib::CMatrixLUSolveM(CMatrixComplex &lua, int &p[], const int n,
                                     CMatrixComplex &b, const int m, int &info,
                                     CDenseSolverReportShell &rep,
                                     CMatrixComplex &x) {

  info = 0;

  CDenseSolver::CMatrixLUSolveM(lua, p, n, b, m, info, rep.GetInnerObj(), x);

  return;
}

static void CAlglib::CMatrixLUSolve(CMatrixComplex &lua, int &p[], const int n,
                                    al_complex &b[], int &info,
                                    CDenseSolverReportShell &rep,
                                    al_complex &x[]) {

  info = 0;

  CDenseSolver::CMatrixLUSolve(lua, p, n, b, info, rep.GetInnerObj(), x);

  return;
}

static void CAlglib::CMatrixMixedSolveM(CMatrixComplex &a, CMatrixComplex &lua,
                                        int &p[], const int n,
                                        CMatrixComplex &b, const int m,
                                        int &info, CDenseSolverReportShell &rep,
                                        CMatrixComplex &x) {

  info = 0;

  CDenseSolver::CMatrixMixedSolveM(a, lua, p, n, b, m, info, rep.GetInnerObj(),
                                   x);

  return;
}

static void CAlglib::CMatrixMixedSolve(CMatrixComplex &a, CMatrixComplex &lua,
                                       int &p[], const int n, al_complex &b[],
                                       int &info, CDenseSolverReportShell &rep,
                                       al_complex &x[]) {

  info = 0;

  CDenseSolver::CMatrixMixedSolve(a, lua, p, n, b, info, rep.GetInnerObj(), x);

  return;
}

static void CAlglib::SPDMatrixSolveM(CMatrixDouble &a, const int n,
                                     const bool isupper, CMatrixDouble &b,
                                     const int m, int &info,
                                     CDenseSolverReportShell &rep,
                                     CMatrixDouble &x) {

  info = 0;

  CDenseSolver::SPDMatrixSolveM(a, n, isupper, b, m, info, rep.GetInnerObj(),
                                x);

  return;
}

static void CAlglib::SPDMatrixSolve(CMatrixDouble &a, const int n,
                                    const bool isupper, double &b[], int &info,
                                    CDenseSolverReportShell &rep, double &x[]) {

  info = 0;

  CDenseSolver::SPDMatrixSolve(a, n, isupper, b, info, rep.GetInnerObj(), x);

  return;
}

static void CAlglib::SPDMatrixCholeskySolveM(
    CMatrixDouble &cha, const int n, const bool isupper, CMatrixDouble &b,
    const int m, int &info, CDenseSolverReportShell &rep, CMatrixDouble &x) {

  info = 0;

  CDenseSolver::SPDMatrixCholeskySolveM(cha, n, isupper, b, m, info,
                                        rep.GetInnerObj(), x);

  return;
}

static void CAlglib::SPDMatrixCholeskySolve(CMatrixDouble &cha, const int n,
                                            const bool isupper, double &b[],
                                            int &info,
                                            CDenseSolverReportShell &rep,
                                            double &x[]) {

  info = 0;

  CDenseSolver::SPDMatrixCholeskySolve(cha, n, isupper, b, info,
                                       rep.GetInnerObj(), x);

  return;
}

static void CAlglib::HPDMatrixSolveM(CMatrixComplex &a, const int n,
                                     const bool isupper, CMatrixComplex &b,
                                     const int m, int &info,
                                     CDenseSolverReportShell &rep,
                                     CMatrixComplex &x) {

  info = 0;

  CDenseSolver::HPDMatrixSolveM(a, n, isupper, b, m, info, rep.GetInnerObj(),
                                x);

  return;
}

static void CAlglib::HPDMatrixSolve(CMatrixComplex &a, const int n,
                                    const bool isupper, al_complex &b[],
                                    int &info, CDenseSolverReportShell &rep,
                                    al_complex &x[]) {

  info = 0;

  CDenseSolver::HPDMatrixSolve(a, n, isupper, b, info, rep.GetInnerObj(), x);

  return;
}

static void CAlglib::HPDMatrixCholeskySolveM(
    CMatrixComplex &cha, const int n, const bool isupper, CMatrixComplex &b,
    const int m, int &info, CDenseSolverReportShell &rep, CMatrixComplex &x) {

  info = 0;

  CDenseSolver::HPDMatrixCholeskySolveM(cha, n, isupper, b, m, info,
                                        rep.GetInnerObj(), x);

  return;
}

static void CAlglib::HPDMatrixCholeskySolve(CMatrixComplex &cha, const int n,
                                            const bool isupper, al_complex &b[],
                                            int &info,
                                            CDenseSolverReportShell &rep,
                                            al_complex &x[]) {

  info = 0;

  CDenseSolver::HPDMatrixCholeskySolve(cha, n, isupper, b, info,
                                       rep.GetInnerObj(), x);

  return;
}

static void CAlglib::RMatrixSolveLS(CMatrixDouble &a, const int nrows,
                                    const int ncols, double &b[],
                                    const double threshold, int &info,
                                    CDenseSolverLSReportShell &rep,
                                    double &x[]) {

  info = 0;

  CDenseSolver::RMatrixSolveLS(a, nrows, ncols, b, threshold, info,
                               rep.GetInnerObj(), x);

  return;
}

static void CAlglib::NlEqCreateLM(const int n, const int m, double &x[],
                                  CNlEqStateShell &state) {

  CNlEq::NlEqCreateLM(n, m, x, state.GetInnerObj());

  return;
}

static void CAlglib::NlEqCreateLM(const int m, double &x[],
                                  CNlEqStateShell &state) {

  int n;

  n = CAp::Len(x);

  CNlEq::NlEqCreateLM(n, m, x, state.GetInnerObj());

  return;
}

static void CAlglib::NlEqSetCond(CNlEqStateShell &state, const double epsf,
                                 const int maxits) {

  CNlEq::NlEqSetCond(state.GetInnerObj(), epsf, maxits);

  return;
}

static void CAlglib::NlEqSetXRep(CNlEqStateShell &state, const bool needxrep) {

  CNlEq::NlEqSetXRep(state.GetInnerObj(), needxrep);

  return;
}

static void CAlglib::NlEqSetStpMax(CNlEqStateShell &state,
                                   const double stpmax) {

  CNlEq::NlEqSetStpMax(state.GetInnerObj(), stpmax);

  return;
}

static bool CAlglib::NlEqIteration(CNlEqStateShell &state) {

  return (CNlEq::NlEqIteration(state.GetInnerObj()));
}

static void CAlglib::NlEqSolve(CNlEqStateShell &state, CNDimensional_Func &func,
                               CNDimensional_Jac &jac, CNDimensional_Rep &rep,
                               bool rep_status, CObject &obj) {

  while (CAlglib::NlEqIteration(state)) {

    if (state.GetNeedF()) {
      func.Func(state.GetInnerObj().m_x, state.GetInnerObj().m_f, obj);

      continue;
    }

    if (state.GetNeedFIJ()) {
      jac.Jac(state.GetInnerObj().m_x, state.GetInnerObj().m_fi,
              state.GetInnerObj().m_j, obj);

      continue;
    }

    if (state.GetInnerObj().m_xupdated) {

      if (rep_status)
        rep.Rep(state.GetInnerObj().m_x, state.GetInnerObj().m_f, obj);

      continue;
    }
    Print("ALGLIB: error in 'nleqsolve' (some derivatives were not provided?)");
    CAp::exception_happened = true;
    return;
  }
}

static void CAlglib::NlEqResults(CNlEqStateShell &state, double &x[],
                                 CNlEqReportShell &rep) {

  CNlEq::NlEqResults(state.GetInnerObj(), x, rep.GetInnerObj());

  return;
}

static void CAlglib::NlEqResultsBuf(CNlEqStateShell &state, double &x[],
                                    CNlEqReportShell &rep) {

  CNlEq::NlEqResultsBuf(state.GetInnerObj(), x, rep.GetInnerObj());

  return;
}

static void CAlglib::NlEqRestartFrom(CNlEqStateShell &state, double &x[]) {

  CNlEq::NlEqRestartFrom(state.GetInnerObj(), x);

  return;
}

static double CAlglib::GammaFunction(const double x) {

  return (CGammaFunc::GammaFunc(x));
}

static double CAlglib::LnGamma(const double x, double &sgngam) {

  sgngam = 0;

  return (CGammaFunc::LnGamma(x, sgngam));
}

static double CAlglib::ErrorFunction(const double x) {

  return (CNormalDistr::ErrorFunction(x));
}

static double CAlglib::ErrorFunctionC(const double x) {

  return (CNormalDistr::ErrorFunctionC(x));
}

static double CAlglib::NormalDistribution(const double x) {

  return (CNormalDistr::NormalDistribution(x));
}

static double CAlglib::InvErF(double e) {

  return (CNormalDistr::InvErF(e));
}

static double CAlglib::InvNormalDistribution(const double y0) {

  return (CNormalDistr::InvNormalDistribution(y0));
}

static double CAlglib::IncompleteGamma(const double a, const double x) {

  return (CIncGammaF::IncompleteGamma(a, x));
}

static double CAlglib::IncompleteGammaC(const double a, const double x) {

  return (CIncGammaF::IncompleteGammaC(a, x));
}

static double CAlglib::InvIncompleteGammaC(const double a, const double y0) {

  return (CIncGammaF::InvIncompleteGammaC(a, y0));
}

static void CAlglib::Airy(const double x, double &ai, double &aip, double &bi,
                          double &bip) {

  ai = 0;
  aip = 0;
  bi = 0;
  bip = 0;

  CAiryF::Airy(x, ai, aip, bi, bip);

  return;
}

static double CAlglib::BesselJ0(const double x) {

  return (CBessel::BesselJ0(x));
}

static double CAlglib::BesselJ1(const double x) {

  return (CBessel::BesselJ1(x));
}

static double CAlglib::BesselJN(const int n, const double x) {

  return (CBessel::BesselJN(n, x));
}

static double CAlglib::BesselY0(const double x) {

  return (CBessel::BesselY0(x));
}

static double CAlglib::BesselY1(const double x) {

  return (CBessel::BesselY1(x));
}

static double CAlglib::BesselYN(const int n, const double x) {

  return (CBessel::BesselYN(n, x));
}

static double CAlglib::BesselI0(const double x) {

  return (CBessel::BesselI0(x));
}

static double CAlglib::BesselI1(const double x) {

  return (CBessel::BesselI1(x));
}

static double CAlglib::BesselK0(const double x) {

  return (CBessel::BesselK0(x));
}

static double CAlglib::BesselK1(const double x) {

  return (CBessel::BesselK1(x));
}

static double CAlglib::BesselKN(const int nn, const double x) {

  return (CBessel::BesselKN(nn, x));
}

static double CAlglib::Beta(const double a, const double b) {

  return (CBetaF::Beta(a, b));
}

static double CAlglib::IncompleteBeta(const double a, const double b,
                                      const double x) {

  return (CIncBetaF::IncompleteBeta(a, b, x));
}

static double CAlglib::InvIncompleteBeta(const double a, const double b,
                                         double y) {

  return (CIncBetaF::InvIncompleteBeta(a, b, y));
}

static double CAlglib::BinomialDistribution(const int k, const int n,
                                            const double p) {

  return (CBinomialDistr::BinomialDistribution(k, n, p));
}

static double CAlglib::BinomialComplDistribution(const int k, const int n,
                                                 const double p) {

  return (CBinomialDistr::BinomialComplDistribution(k, n, p));
}

static double CAlglib::InvBinomialDistribution(const int k, const int n,
                                               const double y) {

  return (CBinomialDistr::InvBinomialDistribution(k, n, y));
}

static double CAlglib::ChebyshevCalculate(int r, const int n, const double x) {

  return (CChebyshev::ChebyshevCalculate(r, n, x));
}

static double CAlglib::ChebyshevSum(double &c[], const int r, const int n,
                                    const double x) {

  return (CChebyshev::ChebyshevSum(c, r, n, x));
}

static void CAlglib::ChebyshevCoefficients(const int n, double &c[]) {

  CChebyshev::ChebyshevCoefficients(n, c);

  return;
}

static void CAlglib::FromChebyshev(double &a[], const int n, double &b[]) {

  CChebyshev::FromChebyshev(a, n, b);

  return;
}

static double CAlglib::ChiSquareDistribution(const double v, const double x) {

  return (CChiSquareDistr::ChiSquareDistribution(v, x));
}

static double CAlglib::ChiSquareComplDistribution(const double v,
                                                  const double x) {

  return (CChiSquareDistr::ChiSquareComplDistribution(v, x));
}

static double CAlglib::InvChiSquareDistribution(const double v,
                                                const double y) {

  return (CChiSquareDistr::InvChiSquareDistribution(v, y));
}

static double CAlglib::DawsonIntegral(const double x) {

  return (CDawson::DawsonIntegral(x));
}

static double CAlglib::EllipticIntegralK(const double m) {

  return (CElliptic::EllipticIntegralK(m));
}

static double CAlglib::EllipticIntegralKhighPrecision(const double m1) {

  return (CElliptic::EllipticIntegralKhighPrecision(m1));
}

static double CAlglib::IncompleteEllipticIntegralK(const double phi,
                                                   const double m) {

  return (CElliptic::IncompleteEllipticIntegralK(phi, m));
}

static double CAlglib::EllipticIntegralE(const double m) {

  return (CElliptic::EllipticIntegralE(m));
}

static double CAlglib::IncompleteEllipticIntegralE(const double phi,
                                                   const double m) {

  return (CElliptic::IncompleteEllipticIntegralE(phi, m));
}

static double CAlglib::ExponentialIntegralEi(const double x) {

  return (CExpIntegrals::ExponentialIntegralEi(x));
}

static double CAlglib::ExponentialIntegralEn(const double x, const int n) {

  return (CExpIntegrals::ExponentialIntegralEn(x, n));
}

static double CAlglib::FDistribution(const int a, const int b, const double x) {

  return (CFDistr::FDistribution(a, b, x));
}

static double CAlglib::FComplDistribution(const int a, const int b,
                                          const double x) {

  return (CFDistr::FComplDistribution(a, b, x));
}

static double CAlglib::InvFDistribution(const int a, const int b,
                                        const double y) {

  return (CFDistr::InvFDistribution(a, b, y));
}

static void CAlglib::FresnelIntegral(const double x, double &c, double &s) {

  CFresnel::FresnelIntegral(x, c, s);

  return;
}

static double CAlglib::HermiteCalculate(const int n, const double x) {

  return (CHermite::HermiteCalculate(n, x));
}

static double CAlglib::HermiteSum(double &c[], const int n, const double x) {

  return (CHermite::HermiteSum(c, n, x));
}

static void CAlglib::HermiteCoefficients(const int n, double &c[]) {

  CHermite::HermiteCoefficients(n, c);

  return;
}

static void CAlglib::JacobianEllipticFunctions(const double u, const double m,
                                               double &sn, double &cn,
                                               double &dn, double &ph) {

  sn = 0;
  cn = 0;
  dn = 0;
  ph = 0;

  CJacobianElliptic::JacobianEllipticFunctions(u, m, sn, cn, dn, ph);

  return;
}

static double CAlglib::LaguerreCalculate(const int n, const double x) {

  return (CLaguerre::LaguerreCalculate(n, x));
}

static double CAlglib::LaguerreSum(double &c[], const int n, const double x) {

  return (CLaguerre::LaguerreSum(c, n, x));
}

static void CAlglib::LaguerreCoefficients(const int n, double &c[]) {

  CLaguerre::LaguerreCoefficients(n, c);

  return;
}

static double CAlglib::LegendreCalculate(const int n, const double x) {

  return (CLegendre::LegendreCalculate(n, x));
}

static double CAlglib::LegendreSum(double &c[], const int n, const double x) {

  return (CLegendre::LegendreSum(c, n, x));
}

static void CAlglib::LegendreCoefficients(const int n, double &c[]) {

  CLegendre::LegendreCoefficients(n, c);

  return;
}

static double CAlglib::PoissonDistribution(const int k, const double m) {

  return (CPoissonDistr::PoissonDistribution(k, m));
}

static double CAlglib::PoissonComplDistribution(const int k, const double m) {

  return (CPoissonDistr::PoissonComplDistribution(k, m));
}

static double CAlglib::InvPoissonDistribution(const int k, const double y) {

  return (CPoissonDistr::InvPoissonDistribution(k, y));
}

static double CAlglib::Psi(const double x) {

  return (CPsiF::Psi(x));
}

static double CAlglib::StudenttDistribution(const int k, const double t) {

  return (CStudenttDistr::StudenttDistribution(k, t));
}

static double CAlglib::InvStudenttDistribution(const int k, const double p) {

  return (CStudenttDistr::InvStudenttDistribution(k, p));
}

static void CAlglib::SineCosineIntegrals(const double x, double &si,
                                         double &ci) {

  si = 0;
  ci = 0;

  CTrigIntegrals::SineCosineIntegrals(x, si, ci);

  return;
}

static void CAlglib::HyperbolicSineCosineIntegrals(const double x, double &shi,
                                                   double &chi) {

  shi = 0;
  chi = 0;

  CTrigIntegrals::HyperbolicSineCosineIntegrals(x, shi, chi);

  return;
}

static void CAlglib::SampleMoments(const double &x[], const int n, double &mean,
                                   double &variance, double &skewness,
                                   double &kurtosis) {

  mean = 0;
  variance = 0;
  skewness = 0;
  kurtosis = 0;

  CBaseStat::SampleMoments(x, n, mean, variance, skewness, kurtosis);
}

static void CAlglib::SampleMoments(const double &x[], double &mean,
                                   double &variance, double &skewness,
                                   double &kurtosis) {

  int n;

  mean = 0;
  variance = 0;
  skewness = 0;
  kurtosis = 0;

  n = CAp::Len(x);

  CBaseStat::SampleMoments(x, n, mean, variance, skewness, kurtosis);
}

static void CAlglib::SampleAdev(const double &x[], const int n, double &adev) {

  adev = 0;

  CBaseStat::SampleAdev(x, n, adev);
}

static void CAlglib::SampleAdev(const double &x[], double &adev) {

  int n = CAp::Len(x);

  adev = 0;

  CBaseStat::SampleAdev(x, n, adev);
}

static void CAlglib::SampleMedian(const double &x[], const int n,
                                  double &median) {

  median = 0;

  CBaseStat::SampleMedian(x, n, median);
}

static void CAlglib::SampleMedian(const double &x[], double &median) {

  int n = CAp::Len(x);

  median = 0;

  CBaseStat::SampleMedian(x, n, median);
}

static void CAlglib::SamplePercentile(const double &x[], const int n,
                                      const double p, double &v) {

  v = 0;

  CBaseStat::SamplePercentile(x, n, p, v);
}

static void CAlglib::SamplePercentile(const double &x[], const double p,
                                      double &v) {

  int n = CAp::Len(x);

  v = 0;

  CBaseStat::SamplePercentile(x, n, p, v);
}

static double CAlglib::Cov2(const double &x[], const double &y[], const int n) {

  return (CBaseStat::Cov2(x, y, n));
}

static double CAlglib::Cov2(const double &x[], const double &y[]) {

  if (CAp::Len(x) != CAp::Len(y)) {
    Print(__FUNCTION__ + ": arrays size are not equal");
    CAp::exception_happened = true;
    return (EMPTY_VALUE);
  }

  int n = CAp::Len(x);

  return (CBaseStat::Cov2(x, y, n));
}

static double CAlglib::PearsonCorr2(const double &x[], const double &y[],
                                    const int n) {

  return (CBaseStat::PearsonCorr2(x, y, n));
}

static double CAlglib::PearsonCorr2(const double &x[], const double &y[]) {

  if (CAp::Len(x) != CAp::Len(y)) {
    Print(__FUNCTION__ + ": arrays size are not equal");
    CAp::exception_happened = true;
    return (EMPTY_VALUE);
  }

  int n = CAp::Len(x);

  return (CBaseStat::PearsonCorr2(x, y, n));
}

static double CAlglib::SpearmanCorr2(const double &x[], const double &y[],
                                     const int n) {

  return (CBaseStat::SpearmanCorr2(x, y, n));
}

static double CAlglib::SpearmanCorr2(const double &x[], const double &y[]) {

  if (CAp::Len(x) != CAp::Len(y)) {
    Print(__FUNCTION__ + ": arrays size are not equal");
    CAp::exception_happened = true;
    return (EMPTY_VALUE);
  }

  int n = CAp::Len(x);

  return (CBaseStat::SpearmanCorr2(x, y, n));
}

static void CAlglib::CovM(const CMatrixDouble &x, const int n, const int m,
                          CMatrixDouble &c) {

  CBaseStat::CovM(x, n, m, c);
}

static void CAlglib::CovM(const CMatrixDouble &x, CMatrixDouble &c) {

  int n = CAp::Rows(x);
  int m = CAp::Cols(x);

  CBaseStat::CovM(x, n, m, c);
}

static void CAlglib::PearsonCorrM(const CMatrixDouble &x, const int n,
                                  const int m, CMatrixDouble &c) {

  CBaseStat::PearsonCorrM(x, n, m, c);
}

static void CAlglib::PearsonCorrM(CMatrixDouble &x, CMatrixDouble &c) {

  int n = CAp::Rows(x);
  int m = CAp::Cols(x);

  CBaseStat::PearsonCorrM(x, n, m, c);
}

static void CAlglib::SpearmanCorrM(const CMatrixDouble &x, const int n,
                                   const int m, CMatrixDouble &c) {

  CBaseStat::SpearmanCorrM(x, n, m, c);
}

static void CAlglib::SpearmanCorrM(const CMatrixDouble &x, CMatrixDouble &c) {

  int n = CAp::Rows(x);
  int m = CAp::Cols(x);

  CBaseStat::SpearmanCorrM(x, n, m, c);
}

static void CAlglib::CovM2(const CMatrixDouble &x, const CMatrixDouble &y,
                           const int n, const int m1, const int m2,
                           CMatrixDouble &c) {

  CBaseStat::CovM2(x, y, n, m1, m2, c);
}

static void CAlglib::CovM2(const CMatrixDouble &x, const CMatrixDouble &y,
                           CMatrixDouble &c) {

  int n = CAp::Rows(x);
  int m1 = CAp::Cols(x);
  int m2 = CAp::Cols(y);

  if (CAp::Rows(x) != CAp::Rows(y)) {
    Print(__FUNCTION__ + ": rows size are not equal");
    CAp::exception_happened = true;
    return;
  }

  CBaseStat::CovM2(x, y, n, m1, m2, c);
}

static void CAlglib::PearsonCorrM2(const CMatrixDouble &x,
                                   const CMatrixDouble &y, const int n,
                                   const int m1, const int m2,
                                   CMatrixDouble &c) {

  CBaseStat::PearsonCorrM2(x, y, n, m1, m2, c);
}

static void CAlglib::PearsonCorrM2(const CMatrixDouble &x,
                                   const CMatrixDouble &y, CMatrixDouble &c) {

  int n = CAp::Rows(x);
  int m1 = CAp::Cols(x);
  int m2 = CAp::Cols(y);

  if (CAp::Rows(x) != CAp::Rows(y)) {
    Print(__FUNCTION__ + ": rows size are not equal");
    CAp::exception_happened = true;
    return;
  }

  CBaseStat::PearsonCorrM2(x, y, n, m1, m2, c);
}

static void CAlglib::SpearmanCorrM2(const CMatrixDouble &x,
                                    const CMatrixDouble &y, const int n,
                                    const int m1, const int m2,
                                    CMatrixDouble &c) {

  CBaseStat::SpearmanCorrM2(x, y, n, m1, m2, c);
}

static void CAlglib::SpearmanCorrM2(const CMatrixDouble &x,
                                    const CMatrixDouble &y, CMatrixDouble &c) {

  int n = CAp::Rows(x);
  int m1 = CAp::Cols(x);
  int m2 = CAp::Cols(y);

  if (CAp::Rows(x) != CAp::Rows(y)) {
    Print(__FUNCTION__ + ": rows size are not equal");
    CAp::exception_happened = true;
    return;
  }

  CBaseStat::SpearmanCorrM2(x, y, n, m1, m2, c);
}

static void CAlglib::PearsonCorrelationSignificance(const double r, const int n,
                                                    double &bothTails,
                                                    double &leftTail,
                                                    double &rightTail) {

  CCorrTests::PearsonCorrSignific(r, n, bothTails, leftTail, rightTail);
}

static void CAlglib::SpearmanRankCorrelationSignificance(const double r,
                                                         const int n,
                                                         double &bothTails,
                                                         double &leftTail,
                                                         double &rightTail) {

  CCorrTests::SpearmanRankCorrSignific(r, n, bothTails, leftTail, rightTail);
}

static void CAlglib::JarqueBeraTest(const double &x[], const int n, double &p) {

  p = 0;

  CJarqueBera::JarqueBeraTest(x, n, p);
}

static void CAlglib::MannWhitneyUTest(const double &x[], const int n,
                                      const double &y[], const int m,
                                      double &bothTails, double &leftTail,
                                      double &rightTail) {

  CMannWhitneyU::CMannWhitneyUTest(x, n, y, m, bothTails, leftTail, rightTail);
}

static void CAlglib::OneSampleSignTest(const double &x[], const int n,
                                       const double median, double &bothTails,
                                       double &leftTail, double &rightTail) {

  CSignTest::OneSampleSignTest(x, n, median, bothTails, leftTail, rightTail);
}

static void CAlglib::StudentTest1(const double &x[], const int n,
                                  const double mean, double &bothTails,
                                  double &leftTail, double &rightTail) {

  CStudentTests::StudentTest1(x, n, mean, bothTails, leftTail, rightTail);
}

static void CAlglib::StudentTest2(const double &x[], const int n,
                                  const double &y[], const int m,
                                  double &bothTails, double &leftTail,
                                  double &rightTail) {

  CStudentTests::StudentTest2(x, n, y, m, bothTails, leftTail, rightTail);
}

static void CAlglib::UnequalVarianceTest(const double &x[], const int n,
                                         const double &y[], const int m,
                                         double &bothTails, double &leftTail,
                                         double &rightTail) {

  CStudentTests::UnequalVarianceTest(x, n, y, m, bothTails, leftTail,
                                     rightTail);
}

static void CAlglib::FTest(const double &x[], const int n, const double &y[],
                           const int m, double &bothTails, double &leftTail,
                           double &rightTail) {

  CVarianceTests::FTest(x, n, y, m, bothTails, leftTail, rightTail);
}

static void CAlglib::OneSampleVarianceTest(double &x[], int n, double variance,
                                           double &bothTails, double &leftTail,
                                           double &rightTail) {

  CVarianceTests::OneSampleVarianceTest(x, n, variance, bothTails, leftTail,
                                        rightTail);
}

static void CAlglib::WilcoxonSignedRankTest(const double &x[], const int n,
                                            const double e, double &bothTails,
                                            double &leftTail,
                                            double &rightTail) {

  CWilcoxonSignedRank::WilcoxonSignedRankTest(x, n, e, bothTails, leftTail,
                                              rightTail);
}

#endif
