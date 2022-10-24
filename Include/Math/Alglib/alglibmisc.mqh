#ifndef ALGLIBMISC_H
#define ALGLIBMISC_H

#include "alglibinternal.mqh"
#include "ap.mqh"

class CKDTree {
public:
  int m_n;
  int m_nx;
  int m_ny;
  int m_normtype;
  int m_kneeded;
  double m_rneeded;
  bool m_selfmatch;
  double m_approxf;
  int m_kcur;
  double m_curdist;
  int m_debugcounter;

  int m_tags;
  double m_boxmin;
  double m_boxmax;
  int m_nodes;
  double m_splits;
  double m_x;
  int m_idx;
  double m_r;
  double m_buf;
  double m_curboxmin;
  double m_curboxmax;

  CMatrixDouble m_xy;

  CKDTree(void);
  ~CKDTree(void);

  void Copy(CKDTree &obj);
};

class CKDTreeShell {
private:
  CKDTree m_innerobj;

public:
  CKDTreeShell(void);
  CKDTreeShell(CKDTree &obj);
  ~CKDTreeShell(void);

  CKDTree *GetInnerObj(void);
};

class CNearestNeighbor {
public:
  static const int m_splitnodesize;
  static const int m_kdtreefirstversion;

  CNearestNeighbor(void);
  ~CNearestNeighbor(void);

  static void KDTreeBuild(CMatrixDouble &xy, const int n, const int nx,
                          const int ny, const int normtype, CKDTree &kdt);
  static void KDTreeBuildTagged(CMatrixDouble &xy, int tags[], const int n,
                                const int nx, const int ny, const int normtype,
                                CKDTree &kdt);
  static int KDTreeQueryKNN(CKDTree &kdt, double x[], const int k,
                            const bool selfmatch);
  static int KDTreeQueryRNN(CKDTree &kdt, double x[], const double r,
                            const bool selfmatch);
  static int KDTreeQueryAKNN(CKDTree &kdt, double x[], int k,
                             const bool selfmatch, const double eps);
  static void KDTreeQueryResultsX(CKDTree &kdt, CMatrixDouble &x);
  static void KDTreeQueryResultsXY(CKDTree &kdt, CMatrixDouble &xy);
  static void KDTreeQueryResultsTags(CKDTree &kdt, int tags[]);
  static void KDTreeQueryResultsDistances(CKDTree &kdt, double r[]);
  static void KDTreeQueryResultsXI(CKDTree &kdt, CMatrixDouble &x);
  static void KDTreeQueryResultsXYI(CKDTree &kdt, CMatrixDouble &xy);
  static void KDTreeQueryResultsTagsI(CKDTree &kdt, int tags[]);
  static void KDTreeQueryResultsDistancesI(CKDTree &kdt, double r[]);

  static void KDTreeAlloc(CSerializer &s, CKDTree &tree);
  static void KDTreeSerialize(CSerializer &s, CKDTree &tree);
  static void KDTreeUnserialize(CSerializer &s, CKDTree &tree);

private:
  static void KDTreeSplit(CKDTree &kdt, const int i1, const int i2, const int d,
                          const double s, int &i3);
  static void KDTreeGenerateTreeRec(CKDTree &kdt, int &nodesoffs,
                                    int &splitsoffs, const int i1, const int i2,
                                    const int maxleafsize);
  static void KDTreeQueryNNRec(CKDTree &kdt, const int offs);
  static void KDTreeInitBox(CKDTree &kdt, double x[]);
  static void KDTreeAllocDataSetIndependent(CKDTree &kdt, const int nx,
                                            const int ny);
  static void KDTreeAllocDataSetDependent(CKDTree &kdt, const int n,
                                          const int nx, const int ny);
  static void KDTreeAllocTemporaries(CKDTree &kdt, const int n, const int nx,
                                     const int ny);
};

#endif
