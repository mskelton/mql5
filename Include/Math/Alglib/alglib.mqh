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
  static void KDTreeBuildTagged(CMatrixDouble &xy, int tags[], const int n,
                                const int nx, const int ny, const int normtype,
                                CKDTreeShell &kdt);
  static void KDTreeBuildTagged(CMatrixDouble &xy, int tags[], const int nx,
                                const int ny, const int normtype,
                                CKDTreeShell &kdt);
  static int KDTreeQueryKNN(CKDTreeShell &kdt, double x[], const int k,
                            const bool selfmatch);
  static int KDTreeQueryKNN(CKDTreeShell &kdt, double x[], const int k);
  static int KDTreeQueryRNN(CKDTreeShell &kdt, double x[], const double r,
                            const bool selfmatch);
  static int KDTreeQueryRNN(CKDTreeShell &kdt, double x[], const double r);
  static int KDTreeQueryAKNN(CKDTreeShell &kdt, double x[], const int k,
                             const bool selfmatch, const double eps);
  static int KDTreeQueryAKNN(CKDTreeShell &kdt, double x[], const int k,
                             const double eps);
  static void KDTreeQueryResultsX(CKDTreeShell &kdt, CMatrixDouble &x);
  static void KDTreeQueryResultsXY(CKDTreeShell &kdt, CMatrixDouble &xy);
  static void KDTreeQueryResultsTags(CKDTreeShell &kdt, int tags[]);
  static void KDTreeQueryResultsDistances(CKDTreeShell &kdt, double r[]);
  static void KDTreeQueryResultsXI(CKDTreeShell &kdt, CMatrixDouble &x);
  static void KDTreeQueryResultsXYI(CKDTreeShell &kdt, CMatrixDouble &xy);
  static void KDTreeQueryResultsTagsI(CKDTreeShell &kdt, int tags[]);
  static void KDTreeQueryResultsDistancesI(CKDTreeShell &kdt, double r[]);

  static void DSOptimalSplit2(double a[], int c[], const int n, int &info,
                              double &threshold, double &pal, double &pbl,
                              double &par, double &pbr, double &cve);
  static void DSOptimalSplit2Fast(double a[], int c[], int tiesbuf[],
                                  int cntbuf[], double bufr[], int bufi[],
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
  static void DFProcess(CDecisionForestShell &df, double x[], double y[]);
  static void DFProcessI(CDecisionForestShell &df, double x[], double y[]);
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
                             int &info, CMatrixDouble &c, int xyc[]);

  static void FisherLDA(CMatrixDouble &xy, const int npoints, const int nvars,
                        const int nclasses, int &info, double w[]);
  static void FisherLDAN(CMatrixDouble &xy, const int npoints, const int nvars,
                         const int nclasses, int &info, CMatrixDouble &w);

  static void LRBuild(CMatrixDouble &xy, const int npoints, const int nvars,
                      int &info, CLinearModelShell &lm, CLRReportShell &ar);
  static void LRBuildS(CMatrixDouble &xy, double s[], const int npoints,
                       const int nvars, int &info, CLinearModelShell &lm,
                       CLRReportShell &ar);
  static void LRBuildZS(CMatrixDouble &xy, double s[], const int npoints,
                        const int nvars, int &info, CLinearModelShell &lm,
                        CLRReportShell &ar);
  static void LRBuildZ(CMatrixDouble &xy, const int npoints, const int nvars,
                       int &info, CLinearModelShell &lm, CLRReportShell &ar);
  static void LRUnpack(CLinearModelShell &lm, double v[], int &nvars);
  static void LRPack(double v[], const int nvars, CLinearModelShell &lm);
  static double LRProcess(CLinearModelShell &lm, double x[]);
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
  static void MLPProcess(CMultilayerPerceptronShell &network, double x[],
                         double y[]);
  static void MLPProcessI(CMultilayerPerceptronShell &network, double x[],
                          double y[]);
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
  static void MLPGrad(CMultilayerPerceptronShell &network, double x[],
                      double desiredy[], double &e, double grad[]);
  static void MLPGradN(CMultilayerPerceptronShell &network, double x[],
                       double desiredy[], double &e, double grad[]);
  static void MLPGradBatch(CMultilayerPerceptronShell &network,
                           CMatrixDouble &xy, const int ssize, double &e,
                           double grad[]);
  static void MLPGradNBatch(CMultilayerPerceptronShell &network,
                            CMatrixDouble &xy, const int ssize, double &e,
                            double grad[]);
  static void MLPHessianNBatch(CMultilayerPerceptronShell &network,
                               CMatrixDouble &xy, const int ssize, double &e,
                               double grad[], CMatrixDouble &h);
  static void MLPHessianBatch(CMultilayerPerceptronShell &network,
                              CMatrixDouble &xy, const int ssize, double &e,
                              double grad[], CMatrixDouble &h);

  static void MNLTrainH(CMatrixDouble &xy, const int npoints, const int nvars,
                        const int nclasses, int &info, CLogitModelShell &lm,
                        CMNLReportShell &rep);
  static void MNLProcess(CLogitModelShell &lm, double x[], double y[]);
  static void MNLProcessI(CLogitModelShell &lm, double x[], double y[]);
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
  static void MCPDSetLC(CMCPDStateShell &s, CMatrixDouble &c, int ct[],
                        const int k);
  static void MCPDSetLC(CMCPDStateShell &s, CMatrixDouble &c, int ct[]);
  static void MCPDSetTikhonovRegularizer(CMCPDStateShell &s, const double v);
  static void MCPDSetPrior(CMCPDStateShell &s, CMatrixDouble &pp);
  static void MCPDSetPredictionWeights(CMCPDStateShell &s, double pw[]);
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
  static void MLPEProcess(CMLPEnsembleShell &ensemble, double x[],
                          double y[]);
  static void MLPEProcessI(CMLPEnsembleShell &ensemble, double x[],
                           double y[]);
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
                            const int nvars, int &info, double s2[],
                            CMatrixDouble &v);

  static void ODESolverRKCK(double y[], const int n, double x[], const int m,
                            const double eps, const double h,
                            CODESolverStateShell &state);
  static void ODESolverRKCK(double y[], double x[], const double eps,
                            const double h, CODESolverStateShell &state);
  static bool ODESolverIteration(CODESolverStateShell &state);
  static void ODESolverSolve(CODESolverStateShell &state,
                             CNDimensional_ODE_RP &diff, CObject &obj);
  static void ODESolverResults(CODESolverStateShell &state, int &m,
                               double xtbl[], CMatrixDouble &ytbl,
                               CODESolverReportShell &rep);

  static void FFTC1D(al_complex a[], const int n);
  static void FFTC1D(al_complex a[]);
  static void FFTC1DInv(al_complex a[], const int n);
  static void FFTC1DInv(al_complex a[]);
  static void FFTR1D(double a[], const int n, al_complex f[]);
  static void FFTR1D(double a[], al_complex f[]);
  static void FFTR1DInv(al_complex f[], const int n, double a[]);
  static void FFTR1DInv(al_complex f[], double a[]);

  static void ConvC1D(al_complex a[], const int m, al_complex b[],
                      const int n, al_complex r[]);
  static void ConvC1DInv(al_complex a[], const int m, al_complex b[],
                         const int n, al_complex r[]);
  static void ConvC1DCircular(al_complex s[], const int m, al_complex r[],
                              const int n, al_complex c[]);
  static void ConvC1DCircularInv(al_complex a[], const int m, al_complex b[],
                                 const int n, al_complex r[]);
  static void ConvR1D(double a[], const int m, double b[], const int n,
                      double r[]);
  static void ConvR1DInv(double a[], const int m, double b[], const int n,
                         double r[]);
  static void ConvR1DCircular(double s[], const int m, double r[],
                              const int n, double c[]);
  static void ConvR1DCircularInv(double a[], const int m, double b[],
                                 const int n, double r[]);
  static void CorrC1D(al_complex signal[], const int n, al_complex pattern[],
                      const int m, al_complex r[]);
  static void CorrC1DCircular(al_complex signal[], const int m,
                              al_complex pattern[], const int n,
                              al_complex c[]);
  static void CorrR1D(double signal[], const int n, double pattern[],
                      const int m, double r[]);
  static void CorrR1DCircular(double signal[], const int m, double pattern[],
                              const int n, double c[]);

  static void FHTR1D(double a[], const int n);
  static void FHTR1DInv(double a[], const int n);

  static void GQGenerateRec(double alpha[], double beta[], const double mu0,
                            const int n, int &info, double x[], double w[]);
  static void GQGenerateGaussLobattoRec(double alpha[], double beta[],
                                        const double mu0, const double a,
                                        const double b, const int n, int &info,
                                        double x[], double w[]);
  static void GQGenerateGaussRadauRec(double alpha[], double beta[],
                                      const double mu0, const double a,
                                      const int n, int &info, double x[],
                                      double w[]);
  static void GQGenerateGaussLegendre(const int n, int &info, double x[],
                                      double w[]);
  static void GQGenerateGaussJacobi(const int n, const double alpha,
                                    const double beta, int &info, double x[],
                                    double w[]);
  static void GQGenerateGaussLaguerre(const int n, const double alpha,
                                      int &info, double x[], double w[]);
  static void GQGenerateGaussHermite(const int n, int &info, double x[],
                                     double w[]);

  static void GKQGenerateRec(double alpha[], double beta[], const double mu0,
                             const int n, int &info, double x[],
                             double wkronrod[], double wgauss[]);
  static void GKQGenerateGaussLegendre(const int n, int &info, double x[],
                                       double wkronrod[], double wgauss[]);
  static void GKQGenerateGaussJacobi(const int n, const double alpha,
                                     const double beta, int &info, double x[],
                                     double wkronrod[], double wgauss[]);
  static void GKQLegendreCalc(const int n, int &info, double x[],
                              double wkronrod[], double wgauss[]);
  static void GKQLegendreTbl(const int n, double x[], double wkronrod[],
                             double wgauss[], double &eps);

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

  static double IDWCalc(CIDWInterpolantShell &z, double x[]);
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
                                double x[], double y[], double w[]);
  static void BarycentricBuildXYW(double x[], double y[], double w[],
                                  const int n, CBarycentricInterpolantShell &b);
  static void BarycentricBuildFloaterHormann(double x[], double y[],
                                             const int n, const int d,
                                             CBarycentricInterpolantShell &b);

  static void PolynomialBar2Cheb(CBarycentricInterpolantShell &p,
                                 const double a, const double b, double t[]);
  static void PolynomialCheb2Bar(double t[], const int n, const double a,
                                 const double b,
                                 CBarycentricInterpolantShell &p);
  static void PolynomialCheb2Bar(double t[], const double a, const double b,
                                 CBarycentricInterpolantShell &p);
  static void PolynomialBar2Pow(CBarycentricInterpolantShell &p, const double c,
                                const double s, double a[]);
  static void PolynomialBar2Pow(CBarycentricInterpolantShell &p, double a[]);
  static void PolynomialPow2Bar(double a[], const int n, const double c,
                                const double s,
                                CBarycentricInterpolantShell &p);
  static void PolynomialPow2Bar(double a[], CBarycentricInterpolantShell &p);
  static void PolynomialBuild(double x[], double y[], const int n,
                              CBarycentricInterpolantShell &p);
  static void PolynomialBuild(double x[], double y[],
                              CBarycentricInterpolantShell &p);
  static void PolynomialBuildEqDist(const double a, const double b, double y[],
                                    const int n,
                                    CBarycentricInterpolantShell &p);
  static void PolynomialBuildEqDist(const double a, const double b, double y[],
                                    CBarycentricInterpolantShell &p);
  static void PolynomialBuildCheb1(const double a, const double b, double y[],
                                   const int n,
                                   CBarycentricInterpolantShell &p);
  static void PolynomialBuildCheb1(const double a, const double b, double y[],
                                   CBarycentricInterpolantShell &p);
  static void PolynomialBuildCheb2(const double a, const double b, double y[],
                                   const int n,
                                   CBarycentricInterpolantShell &p);
  static void PolynomialBuildCheb2(const double a, const double b, double y[],
                                   CBarycentricInterpolantShell &p);
  static double PolynomialCalcEqDist(const double a, const double b,
                                     double f[], const int n, const double t);
  static double PolynomialCalcEqDist(const double a, const double b,
                                     double f[], const double t);
  static double PolynomialCalcCheb1(const double a, const double b, double f[],
                                    const int n, const double t);
  static double PolynomialCalcCheb1(const double a, const double b, double f[],
                                    const double t);
  static double PolynomialCalcCheb2(const double a, const double b, double f[],
                                    const int n, const double t);
  static double PolynomialCalcCheb2(const double a, const double b, double f[],
                                    const double t);

  static void Spline1DBuildLinear(double x[], double y[], const int n,
                                  CSpline1DInterpolantShell &c);
  static void Spline1DBuildLinear(double x[], double y[],
                                  CSpline1DInterpolantShell &c);
  static void Spline1DBuildCubic(double x[], double y[], const int n,
                                 const int boundltype, const double boundl,
                                 const int boundrtype, const double boundr,
                                 CSpline1DInterpolantShell &c);
  static void Spline1DBuildCubic(double x[], double y[],
                                 CSpline1DInterpolantShell &c);
  static void Spline1DGridDiffCubic(double x[], double y[], const int n,
                                    const int boundltype, const double boundl,
                                    const int boundrtype, const double boundr,
                                    double d[]);
  static void Spline1DGridDiffCubic(double x[], double y[], double d[]);
  static void Spline1DGridDiff2Cubic(double x[], double y[], const int n,
                                     const int boundltype, const double boundl,
                                     const int boundrtype, const double boundr,
                                     double d1[], double d2[]);
  static void Spline1DGridDiff2Cubic(double x[], double y[], double d1[],
                                     double d2[]);
  static void Spline1DConvCubic(double x[], double y[], const int n,
                                const int boundltype, const double boundl,
                                const int boundrtype, const double boundr,
                                double x2[], int n2, double y2[]);
  static void Spline1DConvCubic(double x[], double y[], double x2[],
                                double y2[]);
  static void Spline1DConvDiffCubic(double x[], double y[], const int n,
                                    const int boundltype, const double boundl,
                                    const int boundrtype, const double boundr,
                                    double x2[], int n2, double y2[],
                                    double d2[]);
  static void Spline1DConvDiffCubic(double x[], double y[], double x2[],
                                    double y2[], double d2[]);
  static void Spline1DConvDiff2Cubic(double x[], double y[], const int n,
                                     const int boundltype, const double boundl,
                                     const int boundrtype, const double boundr,
                                     double x2[], const int n2, double y2[],
                                     double d2[], double dd2[]);
  static void Spline1DConvDiff2Cubic(double x[], double y[], double x2[],
                                     double y2[], double d2[], double dd2[]);
  static void Spline1DBuildCatmullRom(double x[], double y[], const int n,
                                      const int boundtype, const double tension,
                                      CSpline1DInterpolantShell &c);
  static void Spline1DBuildCatmullRom(double x[], double y[],
                                      CSpline1DInterpolantShell &c);
  static void Spline1DBuildHermite(double x[], double y[], double d[],
                                   const int n, CSpline1DInterpolantShell &c);
  static void Spline1DBuildHermite(double x[], double y[], double d[],
                                   CSpline1DInterpolantShell &c);
  static void Spline1DBuildAkima(double x[], double y[], const int n,
                                 CSpline1DInterpolantShell &c);
  static void Spline1DBuildAkima(double x[], double y[],
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

  static void PolynomialFit(double x[], double y[], const int n, const int m,
                            int &info, CBarycentricInterpolantShell &p,
                            CPolynomialFitReportShell &rep);
  static void PolynomialFit(double x[], double y[], const int m, int &info,
                            CBarycentricInterpolantShell &p,
                            CPolynomialFitReportShell &rep);
  static void PolynomialFitWC(double x[], double y[], double w[],
                              const int n, double xc[], double yc[],
                              int dc[], const int k, const int m, int &info,
                              CBarycentricInterpolantShell &p,
                              CPolynomialFitReportShell &rep);
  static void PolynomialFitWC(double x[], double y[], double w[],
                              double xc[], double yc[], int dc[],
                              const int m, int &info,
                              CBarycentricInterpolantShell &p,
                              CPolynomialFitReportShell &rep);
  static void BarycentricFitFloaterHormannWC(
      double x[], double y[], double w[], const int n, double xc[],
      double yc[], int dc[], const int k, const int m, int &info,
      CBarycentricInterpolantShell &b, CBarycentricFitReportShell &rep);
  static void BarycentricFitFloaterHormann(double x[], double y[],
                                           const int n, const int m, int &info,
                                           CBarycentricInterpolantShell &b,
                                           CBarycentricFitReportShell &rep);
  static void Spline1DFitPenalized(double x[], double y[], const int n,
                                   const int m, const double rho, int &info,
                                   CSpline1DInterpolantShell &s,
                                   CSpline1DFitReportShell &rep);
  static void Spline1DFitPenalized(double x[], double y[], const int m,
                                   const double rho, int &info,
                                   CSpline1DInterpolantShell &s,
                                   CSpline1DFitReportShell &rep);
  static void Spline1DFitPenalizedW(double x[], double y[], double w[],
                                    const int n, const int m, const double rho,
                                    int &info, CSpline1DInterpolantShell &s,
                                    CSpline1DFitReportShell &rep);
  static void Spline1DFitPenalizedW(double x[], double y[], double w[],
                                    const int m, const double rho, int &info,
                                    CSpline1DInterpolantShell &s,
                                    CSpline1DFitReportShell &rep);
  static void Spline1DFitCubicWC(double x[], double y[], double w[],
                                 const int n, double xc[], double yc[],
                                 int dc[], const int k, const int m, int &info,
                                 CSpline1DInterpolantShell &s,
                                 CSpline1DFitReportShell &rep);
  static void Spline1DFitCubicWC(double x[], double y[], double w[],
                                 double xc[], double yc[], int dc[],
                                 const int m, int &info,
                                 CSpline1DInterpolantShell &s,
                                 CSpline1DFitReportShell &rep);
  static void Spline1DFitHermiteWC(double x[], double y[], double w[],
                                   const int n, double xc[], double yc[],
                                   int dc[], const int k, const int m,
                                   int &info, CSpline1DInterpolantShell &s,
                                   CSpline1DFitReportShell &rep);
  static void Spline1DFitHermiteWC(double x[], double y[], double w[],
                                   double xc[], double yc[], int dc[],
                                   const int m, int &info,
                                   CSpline1DInterpolantShell &s,
                                   CSpline1DFitReportShell &rep);
  static void Spline1DFitCubic(double x[], double y[], const int n,
                               const int m, int &info,
                               CSpline1DInterpolantShell &s,
                               CSpline1DFitReportShell &rep);
  static void Spline1DFitCubic(double x[], double y[], const int m, int &info,
                               CSpline1DInterpolantShell &s,
                               CSpline1DFitReportShell &rep);
  static void Spline1DFitHermite(double x[], double y[], const int n,
                                 const int m, int &info,
                                 CSpline1DInterpolantShell &s,
                                 CSpline1DFitReportShell &rep);
  static void Spline1DFitHermite(double x[], double y[], const int m,
                                 int &info, CSpline1DInterpolantShell &s,
                                 CSpline1DFitReportShell &rep);
  static void LSFitLinearW(double y[], double w[], CMatrixDouble &fmatrix,
                           const int n, const int m, int &info, double c[],
                           CLSFitReportShell &rep);
  static void LSFitLinearW(double y[], double w[], CMatrixDouble &fmatrix,
                           int &info, double c[], CLSFitReportShell &rep);
  static void LSFitLinearWC(double y[], double w[], CMatrixDouble &fmatrix,
                            CMatrixDouble &cmatrix, const int n, const int m,
                            const int k, int &info, double c[],
                            CLSFitReportShell &rep);
  static void LSFitLinearWC(double y[], double w[], CMatrixDouble &fmatrix,
                            CMatrixDouble &cmatrix, int &info, double c[],
                            CLSFitReportShell &rep);
  static void LSFitLinear(double y[], CMatrixDouble &fmatrix, const int n,
                          const int m, int &info, double c[],
                          CLSFitReportShell &rep);
  static void LSFitLinear(double y[], CMatrixDouble &fmatrix, int &info,
                          double c[], CLSFitReportShell &rep);
  static void LSFitLinearC(double y[], CMatrixDouble &fmatrix,
                           CMatrixDouble &cmatrix, const int n, const int m,
                           const int k, int &info, double c[],
                           CLSFitReportShell &rep);
  static void LSFitLinearC(double y[], CMatrixDouble &fmatrix,
                           CMatrixDouble &cmatrix, int &info, double c[],
                           CLSFitReportShell &rep);
  static void LSFitCreateWF(CMatrixDouble &x, double y[], double w[],
                            double c[], const int n, const int m, const int k,
                            const double diffstep, CLSFitStateShell &state);
  static void LSFitCreateWF(CMatrixDouble &x, double y[], double w[],
                            double c[], const double diffstep,
                            CLSFitStateShell &state);
  static void LSFitCreateF(CMatrixDouble &x, double y[], double c[],
                           const int n, const int m, const int k,
                           const double diffstep, CLSFitStateShell &state);
  static void LSFitCreateF(CMatrixDouble &x, double y[], double c[],
                           const double diffstep, CLSFitStateShell &state);
  static void LSFitCreateWFG(CMatrixDouble &x, double y[], double w[],
                             double c[], const int n, const int m, const int k,
                             const bool cheapfg, CLSFitStateShell &state);
  static void LSFitCreateWFG(CMatrixDouble &x, double y[], double w[],
                             double c[], const bool cheapfg,
                             CLSFitStateShell &state);
  static void LSFitCreateFG(CMatrixDouble &x, double y[], double c[],
                            const int n, const int m, const int k,
                            const bool cheapfg, CLSFitStateShell &state);
  static void LSFitCreateFG(CMatrixDouble &x, double y[], double c[],
                            const bool cheapfg, CLSFitStateShell &state);
  static void LSFitCreateWFGH(CMatrixDouble &x, double y[], double w[],
                              double c[], const int n, const int m,
                              const int k, CLSFitStateShell &state);
  static void LSFitCreateWFGH(CMatrixDouble &x, double y[], double w[],
                              double c[], CLSFitStateShell &state);
  static void LSFitCreateFGH(CMatrixDouble &x, double y[], double c[],
                             const int n, const int m, const int k,
                             CLSFitStateShell &state);
  static void LSFitCreateFGH(CMatrixDouble &x, double y[], double c[],
                             CLSFitStateShell &state);
  static void LSFitSetCond(CLSFitStateShell &state, const double epsf,
                           const double epsx, const int maxits);
  static void LSFitSetStpMax(CLSFitStateShell &state, const double stpmax);
  static void LSFitSetXRep(CLSFitStateShell &state, const bool needxrep);
  static void LSFitSetScale(CLSFitStateShell &state, double s[]);
  static void LSFitSetBC(CLSFitStateShell &state, double bndl[],
                         double bndu[]);
  static bool LSFitIteration(CLSFitStateShell &state);
  static void LSFitFit(CLSFitStateShell &state, CNDimensional_PFunc &func,
                       CNDimensional_Rep &rep, bool rep_status, CObject &obj);
  static void LSFitFit(CLSFitStateShell &state, CNDimensional_PFunc &func,
                       CNDimensional_PGrad &grad, CNDimensional_Rep &rep,
                       bool rep_status, CObject &obj);
  static void LSFitFit(CLSFitStateShell &state, CNDimensional_PFunc &func,
                       CNDimensional_PGrad &grad, CNDimensional_PHess &hess,
                       CNDimensional_Rep &rep, bool rep_status, CObject &obj);
  static void LSFitResults(CLSFitStateShell &state, int &info, double c[],
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
                                      double t[]);
  static void PSpline3ParameterValues(CPSpline3InterpolantShell &p, int &n,
                                      double t[]);
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

  static void Spline2DBuildBilinear(double x[], double y[], CMatrixDouble &f,
                                    const int m, const int n,
                                    CSpline2DInterpolantShell &c);
  static void Spline2DBuildBicubic(double x[], double y[], CMatrixDouble &f,
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
                           const int ia, const int ja, al_complex u[],
                           const int iu, al_complex v[], const int iv);
  static void RMatrixRank1(const int m, const int n, CMatrixDouble &a,
                           const int ia, const int ja, double u[],
                           const int iu, double v[], const int iv);
  static void CMatrixMVect(const int m, const int n, CMatrixComplex &a,
                           const int ia, const int ja, const int opa,
                           al_complex x[], const int ix, al_complex y[],
                           const int iy);
  static void RMatrixMVect(const int m, const int n, CMatrixDouble &a,
                           const int ia, const int ja, const int opa,
                           double x[], const int ix, double y[],
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
                        double tau[]);
  static void RMatrixLQ(CMatrixDouble &a, const int m, const int n,
                        double tau[]);
  static void CMatrixQR(CMatrixComplex &a, const int m, const int n,
                        al_complex tau[]);
  static void CMatrixLQ(CMatrixComplex &a, const int m, const int n,
                        al_complex tau[]);
  static void RMatrixQRUnpackQ(CMatrixDouble &a, const int m, const int n,
                               double tau[], const int qcolumns,
                               CMatrixDouble &q);
  static void RMatrixQRUnpackR(CMatrixDouble &a, const int m, const int n,
                               CMatrixDouble &r);
  static void RMatrixLQUnpackQ(CMatrixDouble &a, const int m, const int n,
                               double tau[], const int qrows,
                               CMatrixDouble &q);
  static void RMatrixLQUnpackL(CMatrixDouble &a, const int m, const int n,
                               CMatrixDouble &l);
  static void CMatrixQRUnpackQ(CMatrixComplex &a, const int m, const int n,
                               al_complex tau[], const int qcolumns,
                               CMatrixComplex &q);
  static void CMatrixQRUnpackR(CMatrixComplex &a, const int m, const int n,
                               CMatrixComplex &r);
  static void CMatrixLQUnpackQ(CMatrixComplex &a, const int m, const int n,
                               al_complex tau[], const int qrows,
                               CMatrixComplex &q);
  static void CMatrixLQUnpackL(CMatrixComplex &a, const int m, const int n,
                               CMatrixComplex &l);
  static void RMatrixBD(CMatrixDouble &a, const int m, const int n,
                        double tauq[], double taup[]);
  static void RMatrixBDUnpackQ(CMatrixDouble &qp, const int m, const int n,
                               double tauq[], const int qcolumns,
                               CMatrixDouble &q);
  static void RMatrixBDMultiplyByQ(CMatrixDouble &qp, const int m, const int n,
                                   double tauq[], CMatrixDouble &z,
                                   const int zrows, const int zcolumns,
                                   const bool fromtheright,
                                   const bool dotranspose);
  static void RMatrixBDUnpackPT(CMatrixDouble &qp, const int m, const int n,
                                double taup[], const int ptrows,
                                CMatrixDouble &pt);
  static void RMatrixBDMultiplyByP(CMatrixDouble &qp, const int m, const int n,
                                   double taup[], CMatrixDouble &z,
                                   const int zrows, const int zcolumns,
                                   const bool fromtheright,
                                   const bool dotranspose);
  static void RMatrixBDUnpackDiagonals(CMatrixDouble &b, const int m,
                                       const int n, bool &isupper, double d[],
                                       double e[]);
  static void RMatrixHessenberg(CMatrixDouble &a, const int n, double tau[]);
  static void RMatrixHessenbergUnpackQ(CMatrixDouble &a, const int n,
                                       double tau[], CMatrixDouble &q);
  static void RMatrixHessenbergUnpackH(CMatrixDouble &a, const int n,
                                       CMatrixDouble &h);
  static void SMatrixTD(CMatrixDouble &a, const int n, const bool isupper,
                        double tau[], double d[], double e[]);
  static void SMatrixTDUnpackQ(CMatrixDouble &a, const int n,
                               const bool isupper, double tau[],
                               CMatrixDouble &q);
  static void HMatrixTD(CMatrixComplex &a, const int n, const bool isupper,
                        al_complex tau[], double d[], double e[]);
  static void HMatrixTDUnpackQ(CMatrixComplex &a, const int n,
                               const bool isupper, al_complex tau[],
                               CMatrixComplex &q);

  static bool SMatrixEVD(CMatrixDouble &a, const int n, int zneeded,
                         const bool isupper, double d[], CMatrixDouble &z);
  static bool SMatrixEVDR(CMatrixDouble &a, const int n, int zneeded,
                          const bool isupper, double b1, double b2, int &m,
                          double w[], CMatrixDouble &z);
  static bool SMatrixEVDI(CMatrixDouble &a, const int n, int zneeded,
                          const bool isupper, const int i1, const int i2,
                          double w[], CMatrixDouble &z);
  static bool HMatrixEVD(CMatrixComplex &a, const int n, const int zneeded,
                         const bool isupper, double d[], CMatrixComplex &z);
  static bool HMatrixEVDR(CMatrixComplex &a, const int n, const int zneeded,
                          const bool isupper, double b1, double b2, int &m,
                          double w[], CMatrixComplex &z);
  static bool HMatrixEVDI(CMatrixComplex &a, const int n, const int zneeded,
                          const bool isupper, const int i1, const int i2,
                          double w[], CMatrixComplex &z);
  static bool SMatrixTdEVD(double d[], double e[], const int n,
                           const int zneeded, CMatrixDouble &z);
  static bool SMatrixTdEVDR(double d[], double e[], const int n,
                            const int zneeded, const double a, const double b,
                            int &m, CMatrixDouble &z);
  static bool SMatrixTdEVDI(double d[], double e[], const int n,
                            const int zneeded, const int i1, const int i2,
                            CMatrixDouble &z);
  static bool RMatrixEVD(CMatrixDouble &a, const int n, const int vneeded,
                         double wr[], double wi[], CMatrixDouble &vl,
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
                        int pivots[]);
  static void CMatrixLU(CMatrixComplex &a, const int m, const int n,
                        int pivots[]);
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

  static void RMatrixLUInverse(CMatrixDouble &a, int pivots[], const int n,
                               int &info, CMatInvReportShell &rep);
  static void RMatrixLUInverse(CMatrixDouble &a, int pivots[], int &info,
                               CMatInvReportShell &rep);
  static void RMatrixInverse(CMatrixDouble &a, const int n, int &info,
                             CMatInvReportShell &rep);
  static void RMatrixInverse(CMatrixDouble &a, int &info,
                             CMatInvReportShell &rep);
  static void CMatrixLUInverse(CMatrixComplex &a, int pivots[], const int n,
                               int &info, CMatInvReportShell &rep);
  static void CMatrixLUInverse(CMatrixComplex &a, int pivots[], int &info,
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

  static bool RMatrixBdSVD(double d[], double e[], const int n,
                           const bool isupper,
                           bool isfractionalaccuracyrequired, CMatrixDouble &u,
                           const int nru, CMatrixDouble &c, const int ncc,
                           CMatrixDouble &vt, const int ncvt);

  static bool RMatrixSVD(CMatrixDouble &a, const int m, const int n,
                         const int uneeded, const int vtneeded,
                         const int additionalmemory, double w[],
                         CMatrixDouble &u, CMatrixDouble &vt);

  static double RMatrixLUDet(CMatrixDouble &a, int pivots[], const int n);
  static double RMatrixLUDet(CMatrixDouble &a, int pivots[]);
  static double RMatrixDet(CMatrixDouble &a, const int n);
  static double RMatrixDet(CMatrixDouble &a);
  static al_complex CMatrixLUDet(CMatrixComplex &a, int pivots[], const int n);
  static al_complex CMatrixLUDet(CMatrixComplex &a, int pivots[]);
  static al_complex CMatrixDet(CMatrixComplex &a, const int n);
  static al_complex CMatrixDet(CMatrixComplex &a);
  static double SPDMatrixCholeskyDet(CMatrixDouble &a, const int n);
  static double SPDMatrixCholeskyDet(CMatrixDouble &a);
  static double SPDMatrixDet(CMatrixDouble &a, const int n, const bool isupper);
  static double SPDMatrixDet(CMatrixDouble &a);

  static bool SMatrixGEVD(CMatrixDouble &a, const int n, const bool isuppera,
                          CMatrixDouble &b, const bool isupperb,
                          const int zneeded, const int problemtype, double d[],
                          CMatrixDouble &z);
  static bool SMatrixGEVDReduce(CMatrixDouble &a, const int n,
                                const bool isuppera, CMatrixDouble &b,
                                const bool isupperb, const int problemtype,
                                CMatrixDouble &r, bool &isupperr);

  static void RMatrixInvUpdateSimple(CMatrixDouble &inva, const int n,
                                     const int updrow, const int updcolumn,
                                     const double updval);
  static void RMatrixInvUpdateRow(CMatrixDouble &inva, const int n,
                                  const int updrow, double v[]);
  static void RMatrixInvUpdateColumn(CMatrixDouble &inva, const int n,
                                     const int updcolumn, double u[]);
  static void RMatrixInvUpdateUV(CMatrixDouble &inva, const int n, double u[],
                                 double v[]);

  static bool RMatrixSchur(CMatrixDouble &a, const int n, CMatrixDouble &s);

  static void MinCGCreate(const int n, double x[], CMinCGStateShell &state);
  static void MinCGCreate(double x[], CMinCGStateShell &state);
  static void MinCGCreateF(const int n, double x[], double diffstep,
                           CMinCGStateShell &state);
  static void MinCGCreateF(double x[], double diffstep,
                           CMinCGStateShell &state);
  static void MinCGSetCond(CMinCGStateShell &state, double epsg, double epsf,
                           double epsx, int maxits);
  static void MinCGSetScale(CMinCGStateShell &state, double s[]);
  static void MinCGSetXRep(CMinCGStateShell &state, bool needxrep);
  static void MinCGSetCGType(CMinCGStateShell &state, int cgtype);
  static void MinCGSetStpMax(CMinCGStateShell &state, double stpmax);
  static void MinCGSuggestStep(CMinCGStateShell &state, double stp);
  static void MinCGSetPrecDefault(CMinCGStateShell &state);
  static void MinCGSetPrecDiag(CMinCGStateShell &state, double d[]);
  static void MinCGSetPrecScale(CMinCGStateShell &state);
  static bool MinCGIteration(CMinCGStateShell &state);
  static void MinCGOptimize(CMinCGStateShell &state, CNDimensional_Func &func,
                            CNDimensional_Rep &rep, bool rep_status,
                            CObject &obj);
  static void MinCGOptimize(CMinCGStateShell &state, CNDimensional_Grad &grad,
                            CNDimensional_Rep &rep, bool rep_status,
                            CObject &obj);
  static void MinCGResults(CMinCGStateShell &state, double x[],
                           CMinCGReportShell &rep);
  static void MinCGResultsBuf(CMinCGStateShell &state, double x[],
                              CMinCGReportShell &rep);
  static void MinCGRestartFrom(CMinCGStateShell &state, double x[]);

  static void MinBLEICCreate(const int n, double x[],
                             CMinBLEICStateShell &state);
  static void MinBLEICCreate(double x[], CMinBLEICStateShell &state);
  static void MinBLEICCreateF(const int n, double x[], double diffstep,
                              CMinBLEICStateShell &state);
  static void MinBLEICCreateF(double x[], double diffstep,
                              CMinBLEICStateShell &state);
  static void MinBLEICSetBC(CMinBLEICStateShell &state, double bndl[],
                            double bndu[]);
  static void MinBLEICSetLC(CMinBLEICStateShell &state, CMatrixDouble &c,
                            int ct[], const int k);
  static void MinBLEICSetLC(CMinBLEICStateShell &state, CMatrixDouble &c,
                            int ct[]);
  static void MinBLEICSetInnerCond(CMinBLEICStateShell &state,
                                   const double epsg, const double epsf,
                                   const double epsx);
  static void MinBLEICSetOuterCond(CMinBLEICStateShell &state,
                                   const double epsx, const double epsi);
  static void MinBLEICSetScale(CMinBLEICStateShell &state, double s[]);
  static void MinBLEICSetPrecDefault(CMinBLEICStateShell &state);
  static void MinBLEICSetPrecDiag(CMinBLEICStateShell &state, double d[]);
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
  static void MinBLEICResults(CMinBLEICStateShell &state, double x[],
                              CMinBLEICReportShell &rep);
  static void MinBLEICResultsBuf(CMinBLEICStateShell &state, double x[],
                                 CMinBLEICReportShell &rep);
  static void MinBLEICRestartFrom(CMinBLEICStateShell &state, double x[]);

  static void MinLBFGSCreate(const int n, const int m, double x[],
                             CMinLBFGSStateShell &state);
  static void MinLBFGSCreate(const int m, double x[],
                             CMinLBFGSStateShell &state);
  static void MinLBFGSCreateF(const int n, const int m, double x[],
                              const double diffstep,
                              CMinLBFGSStateShell &state);
  static void MinLBFGSCreateF(const int m, double x[], const double diffstep,
                              CMinLBFGSStateShell &state);
  static void MinLBFGSSetCond(CMinLBFGSStateShell &state, const double epsg,
                              const double epsf, const double epsx,
                              const int maxits);
  static void MinLBFGSSetXRep(CMinLBFGSStateShell &state, const bool needxrep);
  static void MinLBFGSSetStpMax(CMinLBFGSStateShell &state,
                                const double stpmax);
  static void MinLBFGSSetScale(CMinLBFGSStateShell &state, double s[]);
  static void MinLBFGSSetPrecDefault(CMinLBFGSStateShell &state);
  static void MinLBFGSSetPrecCholesky(CMinLBFGSStateShell &state,
                                      CMatrixDouble &p, const bool isupper);
  static void MinLBFGSSetPrecDiag(CMinLBFGSStateShell &state, double d[]);
  static void MinLBFGSSetPrecScale(CMinLBFGSStateShell &state);
  static bool MinLBFGSIteration(CMinLBFGSStateShell &state);
  static void MinLBFGSOptimize(CMinLBFGSStateShell &state,
                               CNDimensional_Func &func, CNDimensional_Rep &rep,
                               bool rep_status, CObject &obj);
  static void MinLBFGSOptimize(CMinLBFGSStateShell &state,
                               CNDimensional_Grad &grad, CNDimensional_Rep &rep,
                               bool rep_status, CObject &obj);
  static void MinLBFGSResults(CMinLBFGSStateShell &state, double x[],
                              CMinLBFGSReportShell &rep);
  static void MinLBFGSresultsbuf(CMinLBFGSStateShell &state, double x[],
                                 CMinLBFGSReportShell &rep);
  static void MinLBFGSRestartFrom(CMinLBFGSStateShell &state, double x[]);

  static void MinQPCreate(const int n, CMinQPStateShell &state);
  static void MinQPSetLinearTerm(CMinQPStateShell &state, double b[]);
  static void MinQPSetQuadraticTerm(CMinQPStateShell &state, CMatrixDouble &a,
                                    const bool isupper);
  static void MinQPSetQuadraticTerm(CMinQPStateShell &state, CMatrixDouble &a);
  static void MinQPSetStartingPoint(CMinQPStateShell &state, double x[]);
  static void MinQPSetOrigin(CMinQPStateShell &state, double xorigin[]);
  static void MinQPSetAlgoCholesky(CMinQPStateShell &state);
  static void MinQPSetBC(CMinQPStateShell &state, double bndl[],
                         double bndu[]);
  static void MinQPOptimize(CMinQPStateShell &state);
  static void MinQPResults(CMinQPStateShell &state, double x[],
                           CMinQPReportShell &rep);
  static void MinQPResultsBuf(CMinQPStateShell &state, double x[],
                              CMinQPReportShell &rep);

  static void MinLMCreateVJ(const int n, const int m, double x[],
                            CMinLMStateShell &state);
  static void MinLMCreateVJ(const int m, double x[], CMinLMStateShell &state);
  static void MinLMCreateV(const int n, const int m, double x[],
                           double diffstep, CMinLMStateShell &state);
  static void MinLMCreateV(const int m, double x[], const double diffstep,
                           CMinLMStateShell &state);
  static void MinLMCreateFGH(const int n, double x[], CMinLMStateShell &state);
  static void MinLMCreateFGH(double x[], CMinLMStateShell &state);
  static void MinLMSetCond(CMinLMStateShell &state, const double epsg,
                           const double epsf, const double epsx,
                           const int maxits);
  static void MinLMSetXRep(CMinLMStateShell &state, const bool needxrep);
  static void MinLMSetStpMax(CMinLMStateShell &state, const double stpmax);
  static void MinLMSetScale(CMinLMStateShell &state, double s[]);
  static void MinLMSetBC(CMinLMStateShell &state, double bndl[],
                         double bndu[]);
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
  static void MinLMResults(CMinLMStateShell &state, double x[],
                           CMinLMReportShell &rep);
  static void MinLMResultsBuf(CMinLMStateShell &state, double x[],
                              CMinLMReportShell &rep);
  static void MinLMRestartFrom(CMinLMStateShell &state, double x[]);
  static void MinLMCreateVGJ(const int n, const int m, double x[],
                             CMinLMStateShell &state);
  static void MinLMCreateVGJ(const int m, double x[], CMinLMStateShell &state);
  static void MinLMCreateFGJ(const int n, const int m, double x[],
                             CMinLMStateShell &state);
  static void MinLMCreateFGJ(const int m, double x[], CMinLMStateShell &state);
  static void MinLMCreateFJ(const int n, const int m, double x[],
                            CMinLMStateShell &state);
  static void MinLMCreateFJ(const int m, double x[], CMinLMStateShell &state);

  static void MinLBFGSSetDefaultPreconditioner(CMinLBFGSStateShell &state);
  static void MinLBFGSSetCholeskyPreconditioner(CMinLBFGSStateShell &state,
                                                CMatrixDouble &p, bool isupper);
  static void MinBLEICSetBarrierWidth(CMinBLEICStateShell &state,
                                      const double mu);
  static void MinBLEICSetBarrierDecay(CMinBLEICStateShell &state,
                                      const double mudecay);
  static void MinASACreate(const int n, double x[], double bndl[],
                           double bndu[], CMinASAStateShell &state);
  static void MinASACreate(double x[], double bndl[], double bndu[],
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
  static void MinASAResults(CMinASAStateShell &state, double x[],
                            CMinASAReportShell &rep);
  static void MinASAResultsBuf(CMinASAStateShell &state, double x[],
                               CMinASAReportShell &rep);
  static void MinASARestartFrom(CMinASAStateShell &state, double x[],
                                double bndl[], double bndu[]);

  static void RMatrixSolve(CMatrixDouble &a, const int n, double b[],
                           int &info, CDenseSolverReportShell &rep,
                           double x[]);
  static void RMatrixSolveM(CMatrixDouble &a, const int n, CMatrixDouble &b,
                            const int m, const bool rfs, int &info,
                            CDenseSolverReportShell &rep, CMatrixDouble &x);
  static void RMatrixLUSolve(CMatrixDouble &lua, int p[], const int n,
                             double b[], int &info,
                             CDenseSolverReportShell &rep, double x[]);
  static void RMatrixLUSolveM(CMatrixDouble &lua, int p[], const int n,
                              CMatrixDouble &b, const int m, int &info,
                              CDenseSolverReportShell &rep, CMatrixDouble &x);
  static void RMatrixMixedSolve(CMatrixDouble &a, CMatrixDouble &lua, int p[],
                                const int n, double b[], int &info,
                                CDenseSolverReportShell &rep, double x[]);
  static void RMatrixMixedSolveM(CMatrixDouble &a, CMatrixDouble &lua, int p[],
                                 const int n, CMatrixDouble &b, const int m,
                                 int &info, CDenseSolverReportShell &rep,
                                 CMatrixDouble &x);
  static void CMatrixSolveM(CMatrixComplex &a, const int n, CMatrixComplex &b,
                            const int m, const bool rfs, int &info,
                            CDenseSolverReportShell &rep, CMatrixComplex &x);
  static void CMatrixSolve(CMatrixComplex &a, const int n, al_complex b[],
                           int &info, CDenseSolverReportShell &rep,
                           al_complex x[]);
  static void CMatrixLUSolveM(CMatrixComplex &lua, int p[], const int n,
                              CMatrixComplex &b, const int m, int &info,
                              CDenseSolverReportShell &rep, CMatrixComplex &x);
  static void CMatrixLUSolve(CMatrixComplex &lua, int p[], const int n,
                             al_complex b[], int &info,
                             CDenseSolverReportShell &rep, al_complex x[]);
  static void CMatrixMixedSolveM(CMatrixComplex &a, CMatrixComplex &lua,
                                 int p[], const int n, CMatrixComplex &b,
                                 const int m, int &info,
                                 CDenseSolverReportShell &rep,
                                 CMatrixComplex &x);
  static void CMatrixMixedSolve(CMatrixComplex &a, CMatrixComplex &lua,
                                int p[], const int n, al_complex b[],
                                int &info, CDenseSolverReportShell &rep,
                                al_complex x[]);
  static void SPDMatrixSolveM(CMatrixDouble &a, const int n, const bool isupper,
                              CMatrixDouble &b, const int m, int &info,
                              CDenseSolverReportShell &rep, CMatrixDouble &x);
  static void SPDMatrixSolve(CMatrixDouble &a, const int n, const bool isupper,
                             double b[], int &info,
                             CDenseSolverReportShell &rep, double x[]);
  static void SPDMatrixCholeskySolveM(CMatrixDouble &cha, const int n,
                                      const bool isupper, CMatrixDouble &b,
                                      const int m, int &info,
                                      CDenseSolverReportShell &rep,
                                      CMatrixDouble &x);
  static void SPDMatrixCholeskySolve(CMatrixDouble &cha, const int n,
                                     const bool isupper, double b[], int &info,
                                     CDenseSolverReportShell &rep, double x[]);
  static void HPDMatrixSolveM(CMatrixComplex &a, const int n,
                              const bool isupper, CMatrixComplex &b,
                              const int m, int &info,
                              CDenseSolverReportShell &rep, CMatrixComplex &x);
  static void HPDMatrixSolve(CMatrixComplex &a, const int n, const bool isupper,
                             al_complex b[], int &info,
                             CDenseSolverReportShell &rep, al_complex x[]);
  static void HPDMatrixCholeskySolveM(CMatrixComplex &cha, const int n,
                                      const bool isupper, CMatrixComplex &b,
                                      const int m, int &info,
                                      CDenseSolverReportShell &rep,
                                      CMatrixComplex &x);
  static void HPDMatrixCholeskySolve(CMatrixComplex &cha, const int n,
                                     const bool isupper, al_complex b[],
                                     int &info, CDenseSolverReportShell &rep,
                                     al_complex x[]);
  static void RMatrixSolveLS(CMatrixDouble &a, const int nrows, const int ncols,
                             double b[], const double threshold, int &info,
                             CDenseSolverLSReportShell &rep, double x[]);

  static void NlEqCreateLM(const int n, const int m, double x[],
                           CNlEqStateShell &state);
  static void NlEqCreateLM(const int m, double x[], CNlEqStateShell &state);
  static void NlEqSetCond(CNlEqStateShell &state, const double epsf,
                          const int maxits);
  static void NlEqSetXRep(CNlEqStateShell &state, const bool needxrep);
  static void NlEqSetStpMax(CNlEqStateShell &state, const double stpmax);
  static bool NlEqIteration(CNlEqStateShell &state);
  static void NlEqSolve(CNlEqStateShell &state, CNDimensional_Func &func,
                        CNDimensional_Jac &jac, CNDimensional_Rep &rep,
                        bool rep_status, CObject &obj);
  static void NlEqResults(CNlEqStateShell &state, double x[],
                          CNlEqReportShell &rep);
  static void NlEqResultsBuf(CNlEqStateShell &state, double x[],
                             CNlEqReportShell &rep);
  static void NlEqRestartFrom(CNlEqStateShell &state, double x[]);

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
  static double ChebyshevSum(double c[], const int r, const int n,
                             const double x);
  static void ChebyshevCoefficients(const int n, double c[]);
  static void FromChebyshev(double a[], const int n, double b[]);

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
  static double HermiteSum(double c[], const int n, const double x);
  static void HermiteCoefficients(const int n, double c[]);

  static void JacobianEllipticFunctions(const double u, const double m,
                                        double &sn, double &cn, double &dn,
                                        double &ph);

  static double LaguerreCalculate(const int n, const double x);
  static double LaguerreSum(double c[], const int n, const double x);
  static void LaguerreCoefficients(const int n, double c[]);

  static double LegendreCalculate(const int n, const double x);
  static double LegendreSum(double c[], const int n, const double x);
  static void LegendreCoefficients(const int n, double c[]);

  static double PoissonDistribution(const int k, const double m);
  static double PoissonComplDistribution(const int k, const double m);
  static double InvPoissonDistribution(const int k, const double y);

  static double Psi(const double x);

  static double StudenttDistribution(const int k, const double t);
  static double InvStudenttDistribution(const int k, const double p);

  static void SineCosineIntegrals(const double x, double &si, double &ci);
  static void HyperbolicSineCosineIntegrals(const double x, double &shi,
                                            double &chi);

  static void SampleMoments(const double x[], const int n, double &mean,
                            double &variance, double &skewness,
                            double &kurtosis);
  static void SampleMoments(const double x[], double &mean, double &variance,
                            double &skewness, double &kurtosis);
  static void SampleAdev(const double x[], const int n, double &adev);
  static void SampleAdev(const double x[], double &adev);
  static void SampleMedian(const double x[], const int n, double &median);
  static void SampleMedian(const double x[], double &median);
  static void SamplePercentile(const double x[], const int n, const double p,
                               double &v);
  static void SamplePercentile(const double x[], const double p, double &v);
  static double Cov2(const double x[], const double y[], const int n);
  static double Cov2(const double x[], const double y[]);
  static double PearsonCorr2(const double x[], const double y[], const int n);
  static double PearsonCorr2(const double x[], const double y[]);
  static double SpearmanCorr2(const double x[], const double y[],
                              const int n);
  static double SpearmanCorr2(const double x[], const double y[]);
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

  static void JarqueBeraTest(const double x[], const int n, double &p);

  static void MannWhitneyUTest(const double x[], const int n,
                               const double y[], const int m,
                               double &bothTails, double &leftTail,
                               double &rightTail);

  static void OneSampleSignTest(const double x[], const int n,
                                const double median, double &bothTails,
                                double &leftTail, double &rightTail);

  static void StudentTest1(const double x[], const int n, const double mean,
                           double &bothTails, double &leftTail,
                           double &rightTail);
  static void StudentTest2(const double x[], const int n, const double y[],
                           const int m, double &bothTails, double &leftTail,
                           double &rightTail);
  static void UnequalVarianceTest(const double x[], const int n,
                                  const double y[], const int m,
                                  double &bothTails, double &leftTail,
                                  double &rightTail);

  static void FTest(const double x[], const int n, const double y[],
                    const int m, double &bothTails, double &leftTail,
                    double &rightTail);
  static void OneSampleVarianceTest(double x[], int n, double variance,
                                    double &bothTails, double &leftTail,
                                    double &rightTail);

  static void WilcoxonSignedRankTest(const double x[], const int n,
                                     const double e, double &bothTails,
                                     double &leftTail, double &rightTail);
};


























































































































































































































static void























































































































static void

static void




















































































































































































































static void


static void










static void

static void



















































































































































#endif
