#ifndef DATAANALYSIS_H
#define DATAANALYSIS_H

#include "ap.mqh"
#include "optimization.mqh"
#include "solvers.mqh"
#include "statistics.mqh"

class CCVReport {
public:
  double m_relclserror;
  double m_avgce;
  double m_rmserror;
  double m_avgerror;
  double m_avgrelerror;

  CCVReport(void);
  ~CCVReport(void);
};

class CBdSS {
private:
  static double XLnY(const double x, const double y);
  static double GetCV(int cnt[], const int nc);
  static void TieAddC(int c[], int ties[], const int ntie, const int nc,
                      int cnt[]);
  static void TieSubC(int c[], int ties[], const int ntie, const int nc,
                      int cnt[]);

public:
  CBdSS(void);
  ~CBdSS(void);

  static void DSErrAllocate(const int nclasses, double buf[]);
  static void DSErrAccumulate(double buf[], double y[], double desiredy[]);
  static void DSErrFinish(double buf[]);
  static void DSNormalize(CMatrixDouble &xy, const int npoints, const int nvars,
                          int info, double &means[], double sigmas[]);
  static void DSNormalizeC(CMatrixDouble &xy, const int npoints,
                           const int nvars, int info, double &means[],
                           double sigmas[]);
  static double DSGetMeanMindIstance(CMatrixDouble &xy, const int npoints,
                                     const int nvars);
  static void DSTie(double a[], const int n, int ties[], int &tiecount,
                    int p1[], int p2[]);
  static void DSTieFastI(double a[], int b[], const int n, int ties[],
                         int tiecount, double &bufr[], int bufi[]);
  static void DSOptimalSplit2(double ca[], int cc[], const int n, int &info,
                              double &threshold, double &pal, double &pbl,
                              double &par, double &pbr, double &cve);
  static void DSOptimalSplit2Fast(double a[], int c[], int tiesbuf[],
                                  int cntbuf[], double bufr[], int bufi[],
                                  const int n, const int nc, double alpha,
                                  int &info, double &threshold, double &rms,
                                  double &cvrms);
  static void DSSplitK(double ca[], int cc[], const int n, const int nc,
                       int kmax, int info, double &thresholds[], int &ni,
                       double &cve);
  static void DSOptimalSplitK(double ca[], int cc[], const int n, const int nc,
                              int kmax, int &info, double thresholds[], int &ni,
                              double &cve);
};

class CDecisionForest {
public:
  int m_nvars;
  int m_nclasses;
  int m_ntrees;
  int m_bufsize;
  double m_trees;

  CDecisionForest(void);
  ~CDecisionForest(void);

  void Copy(CDecisionForest &obj);
};

class CDecisionForestShell {
private:
  CDecisionForest m_innerobj;

public:
  CDecisionForestShell(void);
  CDecisionForestShell(CDecisionForest &obj);
  ~CDecisionForestShell(void);

  CDecisionForest *GetInnerObj(void);
};

class CDFReport {
public:
  double m_relclserror;
  double m_avgce;
  double m_rmserror;
  double m_avgerror;
  double m_avgrelerror;
  double m_oobrelclserror;
  double m_oobavgce;
  double m_oobrmserror;
  double m_oobavgerror;
  double m_oobavgrelerror;

  CDFReport(void);
  ~CDFReport(void);

  void Copy(CDFReport &obj);
};

class CDFReportShell {
private:
  CDFReport m_innerobj;

public:
  CDFReportShell(void);
  CDFReportShell(CDFReport &obj);
  ~CDFReportShell(void);

  double GetRelClsError(void);
  void SetRelClsError(const double d);
  double GetAvgCE(void);
  void SetAvgCE(const double d);
  double GetRMSError(void);
  void SetRMSError(const double d);
  double GetAvgError(void);
  void SetAvgError(const double d);
  double GetAvgRelError(void);
  void SetAvgRelError(const double d);
  double GetOOBRelClsError(void);
  void SetOOBRelClsError(const double d);
  double GetOOBAvgCE(void);
  void SetOOBAvgCE(const double d);
  double GetOOBRMSError(void);
  void SetOOBRMSError(const double d);
  double GetOOBAvgError(void);
  void SetOOBAvgError(const double d);
  double GetOOBAvgRelError(void);
  void SetOOBAvgRelError(const double d);
  CDFReport *GetInnerObj(void);
};

class CDFInternalBuffers {
public:
  double m_treebuf;
  int m_idxbuf;
  double m_tmpbufr;
  double m_tmpbufr2;
  int m_tmpbufi;
  int m_classibuf;
  double m_sortrbuf;
  double m_sortrbuf2;
  int m_sortibuf;
  int m_varpool;
  bool m_evsbin;
  double m_evssplits;

  CDFInternalBuffers(void);
  ~CDFInternalBuffers(void);
};

class CDForest {
private:
  static int DFClsError(CDecisionForest &df, CMatrixDouble &xy,
                        const int npoints);
  static void DFProcessInternal(CDecisionForest &df, const int offs, double x[],
                                double y[]);
  static void DFBuildTree(CMatrixDouble &xy, const int npoints, const int nvars,
                          const int nclasses, const int nfeatures,
                          const int nvarsinpool, const int flags,
                          CDFInternalBuffers &bufs);
  static void DFBuildTreeRec(CMatrixDouble &xy, const int npoints,
                             const int nvars, const int nclasses,
                             const int nfeatures, int nvarsinpool,
                             const int flags, int &numprocessed, const int idx1,
                             const int idx2, CDFInternalBuffers &bufs);
  static void DFSplitC(double x[], int c[], int cntbuf[], const int n,
                       const int nc, const int flags, int &info,
                       double threshold, double &e, double &sortrbuf[],
                       int sortibuf[]);
  static void DFSplitR(double x[], double y[], const int n, const int flags,
                       int &info, double &threshold, double &e,
                       double sortrbuf[], double sortrbuf2[]);

public:
  static const int m_innernodewidth;
  static const int m_leafnodewidth;
  static const int m_dfusestrongsplits;
  static const int m_dfuseevs;
  static const int m_dffirstversion;

  CDForest(void);
  ~CDForest(void);

  static void DFBuildRandomDecisionForest(CMatrixDouble &xy, const int npoints,
                                          const int nvars, const int nclasses,
                                          const int ntrees, const double r,
                                          int &info, CDecisionForest &df,
                                          CDFReport &rep);
  static void DFBuildRandomDecisionForestX1(
      CMatrixDouble &xy, const int npoints, const int nvars, const int nclasses,
      const int ntrees, const int nrndvars, const double r, int &info,
      CDecisionForest &df, CDFReport &rep);
  static void DFBuildInternal(CMatrixDouble &xy, const int npoints,
                              const int nvars, const int nclasses,
                              const int ntrees, const int samplesize,
                              const int nfeatures, const int flags, int &info,
                              CDecisionForest &df, CDFReport &rep);
  static void DFProcess(CDecisionForest df, double &x[], double y[]);
  static void DFProcessI(CDecisionForest df, double &x[], double y[]);
  static double DFRelClsError(CDecisionForest &df, CMatrixDouble &xy,
                              const int npoints);
  static double DFAvgCE(CDecisionForest &df, CMatrixDouble &xy,
                        const int npoints);
  static double DFRMSError(CDecisionForest &df, CMatrixDouble &xy,
                           const int npoints);
  static double DFAvgError(CDecisionForest &df, CMatrixDouble &xy,
                           const int npoints);
  static double DFAvgRelError(CDecisionForest &df, CMatrixDouble &xy,
                              const int npoints);
  static void DFCopy(CDecisionForest &df1, CDecisionForest &df2);
  static void DFAlloc(CSerializer &s, CDecisionForest &forest);
  static void DFSerialize(CSerializer &s, CDecisionForest &forest);
  static void DFUnserialize(CSerializer &s, CDecisionForest &forest);
};

class CKMeans {
private:
  static bool SelectCenterPP(CMatrixDouble &xy, const int npoints,
                             const int nvars, CMatrixDouble &centers,
                             bool cbusycenters[], const int ccnt, double d2[],
                             double p[], double tmp[]);

public:
  CKMeans(void);
  ~CKMeans(void);

  static void KMeansGenerate(CMatrixDouble &xy, const int npoints,
                             const int nvars, const int k, const int restarts,
                             int info, CMatrixDouble &c, int &xyc[]);
};

class CLDA {
public:
  CLDA(void);
  ~CLDA(void);

  static void FisherLDA(CMatrixDouble &xy, const int npoints, const int nvars,
                        const int nclasses, int info, double &w[]);
  static void FisherLDAN(CMatrixDouble &xy, const int npoints, const int nvars,
                         const int nclasses, int &info, CMatrixDouble &w);
};

class CLinearModel {
public:
  double m_w;

  CLinearModel(void);
  ~CLinearModel(void);

  void Copy(CLinearModel &obj);
};

class CLinearModelShell {
private:
  CLinearModel m_innerobj;

public:
  CLinearModelShell(void);
  CLinearModelShell(CLinearModel &obj);
  ~CLinearModelShell(void);

  CLinearModel *GetInnerObj(void);
};

class CLRReport {
public:
  double m_rmserror;
  double m_avgerror;
  double m_avgrelerror;
  double m_cvrmserror;
  double m_cvavgerror;
  double m_cvavgrelerror;
  int m_ncvdefects;

  int m_cvdefects;

  CMatrixDouble m_c;

  CLRReport(void);
  ~CLRReport(void);

  void Copy(CLRReport &obj);
};

class CLRReportShell {
private:
  CLRReport m_innerobj;

public:
  CLRReportShell(void);
  CLRReportShell(CLRReport &obj);
  ~CLRReportShell(void);

  double GetRMSError(void);
  void SetRMSError(const double d);
  double GetAvgError(void);
  void SetAvgError(const double d);
  double GetAvgRelError(void);
  void SetAvgRelError(const double d);
  double GetCVRMSError(void);
  void SetCVRMSError(const double d);
  double GetCVAvgError(void);
  void SetCVAvgError(const double d);
  double GetCVAvgRelError(void);
  void SetCVAvgRelError(const double d);
  int GetNCVDEfects(void);
  void SetNCVDEfects(const int i);
  CLRReport *GetInnerObj(void);
};

class CLinReg {
private:
  static void LRInternal(CMatrixDouble xy, double &s[], const int npoints,
                         const int nvars, int &info, CLinearModel &lm,
                         CLRReport &ar);

public:
  static const int m_lrvnum;

  CLinReg(void);
  ~CLinReg(void);

  static void LRBuild(CMatrixDouble &xy, const int npoints, const int nvars,
                      int &info, CLinearModel &lm, CLRReport &ar);
  static void LRBuildS(CMatrixDouble xy, double &s[], const int npoints,
                       const int nvars, int &info, CLinearModel &lm,
                       CLRReport &ar);
  static void LRBuildZS(CMatrixDouble xy, double &s[], const int npoints,
                        const int nvars, int &info, CLinearModel &lm,
                        CLRReport &ar);
  static void LRBuildZ(CMatrixDouble &xy, const int npoints, const int nvars,
                       int &info, CLinearModel &lm, CLRReport &ar);
  static void LRUnpack(CLinearModel lm, double &v[], int &nvars);
  static void LRPack(double v[], const int nvars, CLinearModel &lm);
  static double LRProcess(CLinearModel lm, double &x[]);
  static double LRRMSError(CLinearModel &lm, CMatrixDouble &xy,
                           const int npoints);
  static double LRAvgError(CLinearModel &lm, CMatrixDouble &xy,
                           const int npoints);
  static double LRAvgRelError(CLinearModel &lm, CMatrixDouble &xy,
                              const int npoints);
  static void LRCopy(CLinearModel &lm1, CLinearModel &lm2);
  static void LRLines(CMatrixDouble xy, double &s[], const int n, int &info,
                      double &a, double &b, double &vara, double &varb,
                      double &covab, double &corrab, double &p);
  static void LRLine(CMatrixDouble &xy, const int n, int &info, double &a,
                     double &b);
};

class CMultilayerPerceptron {
public:
  int m_hlnetworktype;
  int m_hlnormtype;

  int m_hllayersizes;
  int m_hlconnections;
  int m_hlneurons;
  int m_structinfo;
  double m_weights;
  double m_columnmeans;
  double m_columnsigmas;
  double m_neurons;
  double m_dfdnet;
  double m_derror;
  double m_x;
  double m_y;
  double m_nwbuf;
  int m_integerbuf;

  CMatrixDouble m_chunks;

  CMultilayerPerceptron(void);
  ~CMultilayerPerceptron(void);

  void Copy(CMultilayerPerceptron &obj);
};

class CMultilayerPerceptronShell {
private:
  CMultilayerPerceptron m_innerobj;

public:
  CMultilayerPerceptronShell(void);
  CMultilayerPerceptronShell(CMultilayerPerceptron &obj);
  ~CMultilayerPerceptronShell(void);

  CMultilayerPerceptron *GetInnerObj(void);
};

class CMLPBase {
private:
  static void AddInputLayer(const int ncount, int lsizes[], int ltypes[],
                            int lconnfirst[], int lconnlast[], int &lastproc);
  static void AddBiasedSummatorLayer(const int ncount, int lsizes[],
                                     int ltypes[], int lconnfirst[],
                                     int lconnlast[], int &lastproc);
  static void AddActivationLayer(const int functype, int lsizes[], int ltypes[],
                                 int lconnfirst[], int lconnlast[],
                                 int &lastproc);
  static void AddZeroLayer(int lsizes[], int ltypes[], int lconnfirst[],
                           int lconnlast[], int &lastproc);
  static void HLAddInputLayer(CMultilayerPerceptron &network, int &connidx,
                              int &neuroidx, int &structinfoidx, int nin);
  static void HLAddOutputLayer(CMultilayerPerceptron &network, int &connidx,
                               int &neuroidx, int &structinfoidx,
                               int &weightsidx, const int k, const int nprev,
                               const int nout, const bool iscls,
                               const bool islinearout);
  static void HLAddHiddenLayer(CMultilayerPerceptron &network, int &connidx,
                               int &neuroidx, int &structinfoidx,
                               int &weightsidx, const int k, const int nprev,
                               const int ncur);
  static void FillHighLevelInformation(CMultilayerPerceptron &network,
                                       const int nin, const int nhid1,
                                       const int nhid2, const int nout,
                                       const bool iscls,
                                       const bool islinearout);
  static void MLPCreate(const int nin, const int nout, int lsizes[],
                        int ltypes[], int lconnfirst[], int lconnlast[],
                        const int layerscount, const bool isclsnet,
                        CMultilayerPerceptron &network);
  static void MLPHessianBatchInternal(CMultilayerPerceptron &network,
                                      CMatrixDouble &xy, const int ssize,
                                      const bool naturalerr, double &e,
                                      double grad[], CMatrixDouble &h);
  static void MLPInternalCalculateGradient(CMultilayerPerceptron &network,
                                           double neurons[], double weights[],
                                           double derror[], double grad[],
                                           const bool naturalerrorfunc);
  static void MLPChunkedGradient(CMultilayerPerceptron &network,
                                 CMatrixDouble &xy, const int cstart,
                                 const int csize, double e, double &grad[],
                                 const bool naturalerrorfunc);
  static double SafeCrossEntropy(const double t, const double z);

public:
  static const int m_mlpvnum;
  static const int m_mlpfirstversion;
  static const int m_nfieldwidth;
  static const int m_hlconm_nfieldwidth;
  static const int m_hlm_nfieldwidth;
  static const int m_chunksize;

  CMLPBase(void);
  ~CMLPBase(void);

  static void MLPCreate0(const int nin, const int nout,
                         CMultilayerPerceptron &network);
  static void MLPCreate1(const int nin, const int nhid, const int nout,
                         CMultilayerPerceptron &network);
  static void MLPCreate2(const int nin, const int nhid1, const int nhid2,
                         const int nout, CMultilayerPerceptron &network);
  static void MLPCreateB0(const int nin, const int nout, const double b,
                          double d, CMultilayerPerceptron &network);
  static void MLPCreateB1(const int nin, const int nhid, const int nout,
                          const double b, double d,
                          CMultilayerPerceptron &network);
  static void MLPCreateB2(const int nin, const int nhid1, const int nhid2,
                          const int nout, const double b, double d,
                          CMultilayerPerceptron &network);
  static void MLPCreateR0(const int nin, const int nout, const double a,
                          const double b, CMultilayerPerceptron &network);
  static void MLPCreateR1(const int nin, const int nhid, const int nout,
                          const double a, const double b,
                          CMultilayerPerceptron &network);
  static void MLPCreateR2(const int nin, const int nhid1, const int nhid2,
                          const int nout, const double a, const double b,
                          CMultilayerPerceptron &network);
  static void MLPCreateC0(const int nin, const int nout,
                          CMultilayerPerceptron &network);
  static void MLPCreateC1(const int nin, const int nhid, const int nout,
                          CMultilayerPerceptron &network);
  static void MLPCreateC2(const int nin, const int nhid1, const int nhid2,
                          const int nout, CMultilayerPerceptron &network);
  static void MLPCopy(CMultilayerPerceptron &network1,
                      CMultilayerPerceptron &network2);
  static void MLPSerializeOld(CMultilayerPerceptron network, double &ra[],
                              int &rlen);
  static void MLPUnserializeOld(double ra[], CMultilayerPerceptron &network);
  static void MLPRandomize(CMultilayerPerceptron &network);
  static void MLPRandomizeFull(CMultilayerPerceptron &network);
  static void MLPInitPreprocessor(CMultilayerPerceptron &network,
                                  CMatrixDouble &xy, const int ssize);
  static void MLPProperties(CMultilayerPerceptron &network, int &nin, int &nout,
                            int &wcount);
  static bool MLPIsSoftMax(CMultilayerPerceptron &network);
  static int MLPGetLayersCount(CMultilayerPerceptron &network);
  static int MLPGetLayerSize(CMultilayerPerceptron &network, const int k);
  static void MLPGetInputScaling(CMultilayerPerceptron &network, const int i,
                                 double &mean, double &sigma);
  static void MLPGetOutputScaling(CMultilayerPerceptron &network, const int i,
                                  double &mean, double &sigma);
  static void MLPGetNeuronInfo(CMultilayerPerceptron &network, const int k,
                               const int i, int &fkind, double &threshold);
  static double MLPGetWeight(CMultilayerPerceptron &network, const int k0,
                             const int i0, const int k1, const int i1);
  static void MLPSetInputScaling(CMultilayerPerceptron &network, const int i,
                                 const double mean, double sigma);
  static void MLPSetOutputScaling(CMultilayerPerceptron &network, const int i,
                                  const double mean, double sigma);
  static void MLPSetNeuronInfo(CMultilayerPerceptron &network, const int k,
                               const int i, const int fkind,
                               const double threshold);
  static void MLPSetWeight(CMultilayerPerceptron &network, const int k0,
                           const int i0, const int k1, const int i1,
                           const double w);
  static void MLPActivationFunction(double net, const int k, double &f,
                                    double &df, double &d2f);
  static void MLPProcess(CMultilayerPerceptron network, double &x[],
                         double y[]);
  static void MLPProcessI(CMultilayerPerceptron network, double &x[],
                          double y[]);
  static double MLPError(CMultilayerPerceptron &network, CMatrixDouble &xy,
                         const int ssize);
  static double MLPErrorN(CMultilayerPerceptron &network, CMatrixDouble &xy,
                          const int ssize);
  static int MLPClsError(CMultilayerPerceptron &network, CMatrixDouble &xy,
                         const int ssize);
  static double MLPRelClsError(CMultilayerPerceptron &network,
                               CMatrixDouble &xy, const int npoints);
  static double MLPAvgCE(CMultilayerPerceptron &network, CMatrixDouble &xy,
                         const int npoints);
  static double MLPRMSError(CMultilayerPerceptron &network, CMatrixDouble &xy,
                            const int npoints);
  static double MLPAvgError(CMultilayerPerceptron &network, CMatrixDouble &xy,
                            const int npoints);
  static double MLPAvgRelError(CMultilayerPerceptron &network,
                               CMatrixDouble &xy, const int npoints);
  static void MLPGrad(CMultilayerPerceptron network, double &x[],
                      double desiredy[], double e, double &grad[]);
  static void MLPGradN(CMultilayerPerceptron network, double &x[],
                       double desiredy[], double e, double &grad[]);
  static void MLPGradBatch(CMultilayerPerceptron &network, CMatrixDouble &xy,
                           const int ssize, double e, double &grad[]);
  static void MLPGradNBatch(CMultilayerPerceptron &network, CMatrixDouble &xy,
                            const int ssize, double e, double &grad[]);
  static void MLPHessianNBatch(CMultilayerPerceptron &network,
                               CMatrixDouble &xy, const int ssize, double &e,
                               double grad[], CMatrixDouble &h);
  static void MLPHessianBatch(CMultilayerPerceptron &network, CMatrixDouble &xy,
                              const int ssize, double e, double &grad[],
                              CMatrixDouble &h);
  static void MLPInternalProcessVector(int structinfo[], double weights[],
                                       double columnmeans[],
                                       double columnsigmas[], double neurons[],
                                       double dfdnet[], double x[], double y[]);
  static void MLPAlloc(CSerializer &s, CMultilayerPerceptron &network);
  static void MLPSerialize(CSerializer &s, CMultilayerPerceptron &network);
  static void MLPUnserialize(CSerializer &s, CMultilayerPerceptron &network);
};

class CLogitModel {
public:
  double m_w;

  CLogitModel(void);
  ~CLogitModel(void);

  void Copy(CLogitModel &obj);
};

class CLogitModelShell {
private:
  CLogitModel m_innerobj;

public:
  CLogitModelShell(void);
  CLogitModelShell(CLogitModel &obj);
  ~CLogitModelShell(void);

  CLogitModel *GetInnerObj(void);
};

class CLogitMCState {
public:
  bool m_brackt;
  bool m_stage1;
  int m_infoc;
  double m_dg;
  double m_dgm;
  double m_dginit;
  double m_dgtest;
  double m_dgx;
  double m_dgxm;
  double m_dgy;
  double m_dgym;
  double m_finit;
  double m_ftest1;
  double m_fm;
  double m_fx;
  double m_fxm;
  double m_fy;
  double m_fym;
  double m_stx;
  double m_sty;
  double m_stmin;
  double m_stmax;
  double m_width;
  double m_width1;
  double m_xtrapf;

  CLogitMCState(void);
  ~CLogitMCState(void);
};

class CMNLReport {
public:
  int m_ngrad;
  int m_nhess;

  CMNLReport(void);
  ~CMNLReport(void);

  void Copy(CMNLReport &obj);
};

class CMNLReportShell {
private:
  CMNLReport m_innerobj;

public:
  CMNLReportShell(void);
  CMNLReportShell(CMNLReport &obj);
  ~CMNLReportShell(void);

  int GetNGrad(void);
  void SetNGrad(const int i);
  int GetNHess(void);
  void SetNHess(const int i);
  CMNLReport *GetInnerObj(void);
};

class CLogit {
private:
  static void MNLIExp(double w[], double x[]);
  static void MNLAllErrors(CLogitModel &lm, CMatrixDouble &xy,
                           const int npoints, double &relcls, double &avgce,
                           double &rms, double &avg, double &avgrel);
  static void MNLMCSrch(const int n, double x[], double f, double &g[],
                        double s[], double &stp, int &info, int &nfev,
                        double wa[], CLogitMCState &state, int &stage);
  static void MNLMCStep(double &stx, double &fx, double &dx, double &sty,
                        double &fy, double &dy, double &stp, const double fp,
                        const double dp, bool &brackt, const double stmin,
                        const double stmax, int &info);

public:
  static const double m_xtol;
  static const double m_ftol;
  static const double m_gtol;
  static const int m_maxfev;
  static const double m_stpmin;
  static const double m_stpmax;
  static const int m_logitvnum;

  CLogit(void);
  ~CLogit(void);

  static void MNLTrainH(CMatrixDouble &xy, const int npoints, const int nvars,
                        const int nclasses, int &info, CLogitModel &lm,
                        CMNLReport &rep);
  static void MNLProcess(CLogitModel lm, double &x[], double y[]);
  static void MNLProcessI(CLogitModel lm, double &x[], double y[]);
  static void MNLUnpack(CLogitModel &lm, CMatrixDouble &a, int &nvars,
                        int &nclasses);
  static void MNLPack(CMatrixDouble &a, const int nvars, const int nclasses,
                      CLogitModel &lm);
  static void MNLCopy(CLogitModel &lm1, CLogitModel &lm2);
  static double MNLAvgCE(CLogitModel &lm, CMatrixDouble &xy, const int npoints);
  static double MNLRelClsError(CLogitModel &lm, CMatrixDouble &xy,
                               const int npoints);
  static double MNLRMSError(CLogitModel &lm, CMatrixDouble &xy,
                            const int npoints);
  static double MNLAvgError(CLogitModel &lm, CMatrixDouble &xy,
                            const int npoints);
  static double MNLAvgRelError(CLogitModel &lm, CMatrixDouble &xy,
                               const int ssize);
  static int MNLClsError(CLogitModel &lm, CMatrixDouble &xy, const int npoints);
};

class CMCPDState {
public:
  int m_n;
  int m_npairs;
  int m_ccnt;
  double m_regterm;
  int m_repinneriterationscount;
  int m_repouteriterationscount;
  int m_repnfev;
  int m_repterminationtype;
  CMinBLEICState m_bs;
  CMinBLEICReport m_br;

  int m_states;
  int m_ct;
  double m_pw;
  double m_tmpp;
  double m_effectivew;
  double m_effectivebndl;
  double m_effectivebndu;
  int m_effectivect;
  double m_h;

  CMatrixDouble m_data;
  CMatrixDouble m_ec;
  CMatrixDouble m_bndl;
  CMatrixDouble m_bndu;
  CMatrixDouble m_c;
  CMatrixDouble m_priorp;
  CMatrixDouble m_effectivec;
  CMatrixDouble m_p;

  CMCPDState(void);
  ~CMCPDState(void);

  void Copy(CMCPDState &obj);
};

class CMCPDStateShell {
private:
  CMCPDState m_innerobj;

public:
  CMCPDStateShell(void);
  CMCPDStateShell(CMCPDState &obj);
  ~CMCPDStateShell(void);

  CMCPDState *GetInnerObj(void);
};

class CMCPDReport {
public:
  int m_inneriterationscount;
  int m_outeriterationscount;
  int m_nfev;
  int m_terminationtype;

  CMCPDReport(void);
  ~CMCPDReport(void);

  void Copy(CMCPDReport &obj);
};

class CMCPDReportShell {
private:
  CMCPDReport m_innerobj;

public:
  CMCPDReportShell(void);
  CMCPDReportShell(CMCPDReport &obj);
  ~CMCPDReportShell(void);

  int GetInnerIterationsCount(void);
  void SetInnerIterationsCount(const int i);
  int GetOuterIterationsCount(void);
  void SetOuterIterationsCount(const int i);
  int GetNFev(void);
  void SetNFev(const int i);
  int GetTerminationType(void);
  void SetTerminationType(const int i);
  CMCPDReport *GetInnerObj(void);
};

class CMarkovCPD {
private:
  static void MCPDInit(const int n, const int entrystate, const int exitstate,
                       CMCPDState &s);

public:
  static const double m_xtol;

  CMarkovCPD(void);
  ~CMarkovCPD(void);

  static void MCPDCreate(const int n, CMCPDState &s);
  static void MCPDCreateEntry(const int n, const int entrystate, CMCPDState &s);
  static void MCPDCreateExit(const int n, const int exitstate, CMCPDState &s);
  static void MCPDCreateEntryExit(const int n, const int entrystate,
                                  const int exitstate, CMCPDState &s);
  static void MCPDAddTrack(CMCPDState &s, CMatrixDouble &xy, const int k);
  static void MCPDSetEC(CMCPDState &s, CMatrixDouble &ec);
  static void MCPDAddEC(CMCPDState &s, const int i, const int j,
                        const double c);
  static void MCPDSetBC(CMCPDState &s, CMatrixDouble &bndl,
                        CMatrixDouble &bndu);
  static void MCPDAddBC(CMCPDState &s, const int i, const int j, double bndl,
                        double bndu);
  static void MCPDSetLC(CMCPDState s, CMatrixDouble &c, int &ct[], const int k);
  static void MCPDSetTikhonovRegularizer(CMCPDState &s, const double v);
  static void MCPDSetPrior(CMCPDState &s, CMatrixDouble &cpp);
  static void MCPDSetPredictionWeights(CMCPDState s, double &pw[]);
  static void MCPDSolve(CMCPDState &s);
  static void MCPDResults(CMCPDState &s, CMatrixDouble &p, CMCPDReport &rep);
};

class CMLPReport {
public:
  int m_ngrad;
  int m_nhess;
  int m_ncholesky;

  CMLPReport(void);
  ~CMLPReport(void);

  void Copy(CMLPReport &obj);
};

class CMLPReportShell {
private:
  CMLPReport m_innerobj;

public:
  CMLPReportShell(void);
  CMLPReportShell(CMLPReport &obj);
  ~CMLPReportShell(void);

  int GetNGrad(void);
  void SetNGrad(const int i);
  int GetNHess(void);
  void SetNHess(const int i);
  int GetNCholesky(void);
  void SetNCholesky(const int i);
  CMLPReport *GetInnerObj(void);
};

class CMLPCVReport {
public:
  double m_relclserror;
  double m_avgce;
  double m_rmserror;
  double m_avgerror;
  double m_avgrelerror;

  CMLPCVReport(void);
  ~CMLPCVReport(void);

  void Copy(CMLPCVReport &obj);
};

class CMLPCVReportShell {
private:
  CMLPCVReport m_innerobj;

public:
  CMLPCVReportShell(void);
  CMLPCVReportShell(CMLPCVReport &obj);
  ~CMLPCVReportShell(void);

  double GetRelClsError(void);
  void SetRelClsError(const double d);
  double GetAvgCE(void);
  void SetAvgCE(const double d);
  double GetRMSError(void);
  void SetRMSError(const double d);
  double GetAvgError(void);
  void SetAvgError(const double d);
  double GetAvgRelError(void);
  void SetAvgRelError(const double d);
  CMLPCVReport *GetInnerObj(void);
};

class CMLPTrain {
private:
  static void MLPKFoldCVGeneral(CMultilayerPerceptron &n, CMatrixDouble &xy,
                                const int npoints, const double decay,
                                const int restarts, const int foldscount,
                                const bool lmalgorithm, const double wstep,
                                const int maxits, int &info, CMLPReport &rep,
                                CMLPCVReport &cvrep);
  static void MLPKFoldSplit(CMatrixDouble &xy, const int npoints,
                            const int nclasses, const int foldscount,
                            const bool stratifiedsplits, int folds[]);

public:
  static const double m_mindecay;

  CMLPTrain(void);
  ~CMLPTrain(void);

  static void MLPTrainLM(CMultilayerPerceptron &network, CMatrixDouble &xy,
                         const int npoints, double decay, const int restarts,
                         int &info, CMLPReport &rep);
  static void MLPTrainLBFGS(CMultilayerPerceptron &network, CMatrixDouble &xy,
                            const int npoints, double decay, const int restarts,
                            const double wstep, int maxits, int &info,
                            CMLPReport &rep);
  static void MLPTrainES(CMultilayerPerceptron &network, CMatrixDouble &trnxy,
                         const int trnsize, CMatrixDouble &valxy,
                         const int valsize, const double decay,
                         const int restarts, int &info, CMLPReport &rep);
  static void MLPKFoldCVLBFGS(CMultilayerPerceptron &network, CMatrixDouble &xy,
                              const int npoints, const double decay,
                              const int restarts, const double wstep,
                              const int maxits, const int foldscount, int &info,
                              CMLPReport &rep, CMLPCVReport &cvrep);
  static void MLPKFoldCVLM(CMultilayerPerceptron &network, CMatrixDouble &xy,
                           const int npoints, const double decay,
                           const int restarts, int foldscount, int &info,
                           CMLPReport &rep, CMLPCVReport &cvrep);
};

class CMLPEnsemble {
public:
  int m_ensemblesize;
  int m_nin;
  int m_nout;
  int m_wcount;
  bool m_issoftmax;
  bool m_postprocessing;
  int m_serializedlen;

  int m_structinfo;
  double m_weights;
  double m_columnmeans;
  double m_columnsigmas;
  double m_serializedmlp;
  double m_tmpweights;
  double m_tmpmeans;
  double m_tmpsigmas;
  double m_neurons;
  double m_dfdnet;
  double m_y;

  CMLPEnsemble(void);
  ~CMLPEnsemble(void);

  void Copy(CMLPEnsemble &obj);
};

class CMLPEnsembleShell {
private:
  CMLPEnsemble m_innerobj;

public:
  CMLPEnsembleShell(void);
  CMLPEnsembleShell(CMLPEnsemble &obj);
  ~CMLPEnsembleShell(void);

  CMLPEnsemble *GetInnerObj(void);
};

class CMLPE {
private:
  static void MLPEAllErrors(CMLPEnsemble &ensemble, CMatrixDouble &xy,
                            const int npoints, double &relcls, double &avgce,
                            double &rms, double &avg, double &avgrel);
  static void MLPEBaggingInternal(CMLPEnsemble &ensemble, CMatrixDouble &xy,
                                  const int npoints, const double decay,
                                  const int restarts, const double wstep,
                                  const int maxits, const bool lmalgorithm,
                                  int &info, CMLPReport &rep,
                                  CMLPCVReport &ooberrors);

public:
  static const int m_mlpntotaloffset;
  static const int m_mlpevnum;

  CMLPE(void);
  ~CMLPE(void);

  static void MLPECreate0(const int nin, const int nout, const int ensemblesize,
                          CMLPEnsemble &ensemble);
  static void MLPECreate1(const int nin, const int nhid, const int nout,
                          const int ensemblesize, CMLPEnsemble &ensemble);
  static void MLPECreate2(const int nin, const int nhid1, const int nhid2,
                          const int nout, const int ensemblesize,
                          CMLPEnsemble &ensemble);
  static void MLPECreateB0(const int nin, const int nout, const double b,
                           const double d, const int ensemblesize,
                           CMLPEnsemble &ensemble);
  static void MLPECreateB1(const int nin, const int nhid, const int nout,
                           const double b, const double d,
                           const int ensemblesize, CMLPEnsemble &ensemble);
  static void MLPECreateB2(const int nin, const int nhid1, const int nhid2,
                           const int nout, const double b, const double d,
                           const int ensemblesize, CMLPEnsemble &ensemble);
  static void MLPECreateR0(const int nin, const int nout, const double a,
                           const double b, const int ensemblesize,
                           CMLPEnsemble &ensemble);
  static void MLPECreateR1(const int nin, const int nhid, const int nout,
                           const double a, const double b,
                           const int ensemblesize, CMLPEnsemble &ensemble);
  static void MLPECreateR2(const int nin, const int nhid1, const int nhid2,
                           const int nout, const double a, const double b,
                           const int ensemblesize, CMLPEnsemble &ensemble);
  static void MLPECreateC0(const int nin, const int nout,
                           const int ensemblesize, CMLPEnsemble &ensemble);
  static void MLPECreateC1(const int nin, const int nhid, const int nout,
                           const int ensemblesize, CMLPEnsemble &ensemble);
  static void MLPECreateC2(const int nin, const int nhid1, const int nhid2,
                           const int nout, const int ensemblesize,
                           CMLPEnsemble &ensemble);
  static void MLPECreateFromNetwork(CMultilayerPerceptron &network,
                                    const int ensemblesize,
                                    CMLPEnsemble &ensemble);
  static void MLPECopy(CMLPEnsemble &ensemble1, CMLPEnsemble &ensemble2);
  static void MLPESerialize(CMLPEnsemble ensemble, double &ra[], int &rlen);
  static void MLPEUnserialize(double ra[], CMLPEnsemble &ensemble);
  static void MLPERandomize(CMLPEnsemble &ensemble);
  static void MLPEProperties(CMLPEnsemble &ensemble, int &nin, int &nout);
  static bool MLPEIsSoftMax(CMLPEnsemble &ensemble);
  static void MLPEProcess(CMLPEnsemble ensemble, double &x[], double y[]);
  static void MLPEProcessI(CMLPEnsemble ensemble, double &x[], double y[]);
  static double MLPERelClsError(CMLPEnsemble &ensemble, CMatrixDouble &xy,
                                const int npoints);
  static double MLPEAvgCE(CMLPEnsemble &ensemble, CMatrixDouble &xy,
                          const int npoints);
  static double MLPERMSError(CMLPEnsemble &ensemble, CMatrixDouble &xy,
                             const int npoints);
  static double MLPEAvgError(CMLPEnsemble &ensemble, CMatrixDouble &xy,
                             const int npoints);
  static double MLPEAvgRelError(CMLPEnsemble &ensemble, CMatrixDouble &xy,
                                const int npoints);
  static void MLPEBaggingLM(CMLPEnsemble &ensemble, CMatrixDouble &xy,
                            const int npoints, const double decay,
                            const int restarts, int &info, CMLPReport &rep,
                            CMLPCVReport &ooberrors);
  static void MLPEBaggingLBFGS(CMLPEnsemble &ensemble, CMatrixDouble &xy,
                               const int npoints, const double decay,
                               const int restarts, const double wstep,
                               const int maxits, int &info, CMLPReport &rep,
                               CMLPCVReport &ooberrors);
  static void MLPETrainES(CMLPEnsemble &ensemble, CMatrixDouble &xy,
                          const int npoints, const double decay,
                          const int restarts, int &info, CMLPReport &rep);
};

class CPCAnalysis {
public:
  CPCAnalysis(void);
  ~CPCAnalysis(void);

  static void PCABuildBasis(CMatrixDouble &x, const int npoints,
                            const int nvars, int info, double &s2[],
                            CMatrixDouble &v);
};

#endif
