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

  int m_tags[];
  double m_boxmin[];
  double m_boxmax[];
  int m_nodes[];
  double m_splits[];
  double m_x[];
  int m_idx[];
  double m_r[];
  double m_buf[];
  double m_curboxmin[];
  double m_curboxmax[];

  CMatrixDouble m_xy;

  CKDTree(void);
  ~CKDTree(void);

  void Copy(CKDTree &obj);
};

CKDTree::CKDTree(void) {}

CKDTree::~CKDTree(void) {}

void CKDTree::Copy(CKDTree &obj) {

  m_n = obj.m_n;
  m_nx = obj.m_nx;
  m_ny = obj.m_ny;
  m_normtype = obj.m_normtype;
  m_kneeded = obj.m_kneeded;
  m_rneeded = obj.m_rneeded;
  m_selfmatch = obj.m_selfmatch;
  m_approxf = obj.m_approxf;
  m_kcur = obj.m_kcur;
  m_curdist = obj.m_curdist;
  m_debugcounter = obj.m_debugcounter;

  ArrayCopy(m_tags, obj.m_tags);
  ArrayCopy(m_boxmin, obj.m_boxmin);
  ArrayCopy(m_boxmax, obj.m_boxmax);
  ArrayCopy(m_nodes, obj.m_nodes);
  ArrayCopy(m_splits, obj.m_splits);
  ArrayCopy(m_x, obj.m_x);
  ArrayCopy(m_idx, obj.m_idx);
  ArrayCopy(m_r, obj.m_r);
  ArrayCopy(m_buf, obj.m_buf);
  ArrayCopy(m_curboxmin, obj.m_curboxmin);
  ArrayCopy(m_curboxmax, obj.m_curboxmax);

  m_xy = obj.m_xy;
}

class CKDTreeShell {
private:
  CKDTree m_innerobj;

public:
  CKDTreeShell(void);
  CKDTreeShell(CKDTree &obj);
  ~CKDTreeShell(void);

  CKDTree *GetInnerObj(void);
};

CKDTreeShell::CKDTreeShell(void) {}

CKDTreeShell::CKDTreeShell(CKDTree &obj) {

  m_innerobj.Copy(obj);
}

CKDTreeShell::~CKDTreeShell(void) {}

CKDTree *CKDTreeShell::GetInnerObj(void) {
  return (GetPointer(m_innerobj));
}

class CNearestNeighbor {
public:
  static const int m_splitnodesize;
  static const int m_kdtreefirstversion;

  CNearestNeighbor(void);
  ~CNearestNeighbor(void);

  static void KDTreeBuild(CMatrixDouble &xy, const int n, const int nx,
                          const int ny, const int normtype, CKDTree &kdt);
  static void KDTreeBuildTagged(CMatrixDouble &xy, int &tags[], const int n,
                                const int nx, const int ny, const int normtype,
                                CKDTree &kdt);
  static int KDTreeQueryKNN(CKDTree &kdt, double &x[], const int k,
                            const bool selfmatch);
  static int KDTreeQueryRNN(CKDTree &kdt, double &x[], const double r,
                            const bool selfmatch);
  static int KDTreeQueryAKNN(CKDTree &kdt, double &x[], int k,
                             const bool selfmatch, const double eps);
  static void KDTreeQueryResultsX(CKDTree &kdt, CMatrixDouble &x);
  static void KDTreeQueryResultsXY(CKDTree &kdt, CMatrixDouble &xy);
  static void KDTreeQueryResultsTags(CKDTree &kdt, int &tags[]);
  static void KDTreeQueryResultsDistances(CKDTree &kdt, double &r[]);
  static void KDTreeQueryResultsXI(CKDTree &kdt, CMatrixDouble &x);
  static void KDTreeQueryResultsXYI(CKDTree &kdt, CMatrixDouble &xy);
  static void KDTreeQueryResultsTagsI(CKDTree &kdt, int &tags[]);
  static void KDTreeQueryResultsDistancesI(CKDTree &kdt, double &r[]);

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
  static void KDTreeInitBox(CKDTree &kdt, double &x[]);
  static void KDTreeAllocDataSetIndependent(CKDTree &kdt, const int nx,
                                            const int ny);
  static void KDTreeAllocDataSetDependent(CKDTree &kdt, const int n,
                                          const int nx, const int ny);
  static void KDTreeAllocTemporaries(CKDTree &kdt, const int n, const int nx,
                                     const int ny);
};

const int CNearestNeighbor::m_splitnodesize = 6;
const int CNearestNeighbor::m_kdtreefirstversion = 0;

CNearestNeighbor::CNearestNeighbor(void) {}

CNearestNeighbor::~CNearestNeighbor(void) {}

static void CNearestNeighbor::KDTreeBuild(CMatrixDouble &xy, const int n,
                                          const int nx, const int ny,
                                          const int normtype, CKDTree &kdt) {

  int i = 0;

  int tags[];

  if (!CAp::Assert(n >= 1, __FUNCTION__ + ": N<1!"))
    return;

  if (!CAp::Assert(nx >= 1, __FUNCTION__ + ": NX<1!"))
    return;

  if (!CAp::Assert(ny >= 0, __FUNCTION__ + ": NY<0!"))
    return;

  if (!CAp::Assert(normtype >= 0 && normtype <= 2,
                   __FUNCTION__ + ": incorrect NormType!"))
    return;

  if (!CAp::Assert(CAp::Rows(xy) >= n, __FUNCTION__ + ": rows(X)<N!"))
    return;

  if (!CAp::Assert(CAp::Cols(xy) >= nx + ny, __FUNCTION__ + ": cols(X)<NX+NY!"))
    return;

  if (!CAp::Assert(CApServ::IsFiniteMatrix(xy, n, nx + ny),
                   __FUNCTION__ + ": X contains infinite or NaN values!"))
    return;

  ArrayResizeAL(tags, n);
  for (i = 0; i <= n - 1; i++)
    tags[i] = 0;

  KDTreeBuildTagged(xy, tags, n, nx, ny, normtype, kdt);
}

static void CNearestNeighbor::KDTreeBuildTagged(CMatrixDouble &xy, int &tags[],
                                                const int n, const int nx,
                                                const int ny,
                                                const int normtype,
                                                CKDTree &kdt) {

  int i = 0;
  int j = 0;
  int maxnodes = 0;
  int nodesoffs = 0;
  int splitsoffs = 0;
  int i_ = 0;
  int i1_ = 0;

  if (!CAp::Assert(n >= 1, __FUNCTION__ + ": N<1!"))
    return;

  if (!CAp::Assert(nx >= 1, __FUNCTION__ + ": NX<1!"))
    return;

  if (!CAp::Assert(ny >= 0, __FUNCTION__ + ": NY<0!"))
    return;

  if (!CAp::Assert(normtype >= 0 && normtype <= 2,
                   __FUNCTION__ + ": incorrect NormType!"))
    return;

  if (!CAp::Assert(CAp::Rows(xy) >= n, __FUNCTION__ + ": rows(X)<N!"))
    return;

  if (!CAp::Assert(CAp::Cols(xy) >= nx + ny, __FUNCTION__ + ": cols(X)<NX+NY!"))
    return;

  if (!CAp::Assert(CApServ::IsFiniteMatrix(xy, n, nx + ny),
                   __FUNCTION__ + ": X contains infinite or NaN values!"))
    return;

  kdt.m_n = n;
  kdt.m_nx = nx;
  kdt.m_ny = ny;
  kdt.m_normtype = normtype;

  KDTreeAllocDataSetIndependent(kdt, nx, ny);
  KDTreeAllocDataSetDependent(kdt, n, nx, ny);

  for (i = 0; i <= n - 1; i++) {
    for (i_ = 0; i_ <= nx - 1; i_++)
      kdt.m_xy[i].Set(i_, xy[i][i_]);
    i1_ = -nx;
    for (i_ = nx; i_ <= 2 * nx + ny - 1; i_++)
      kdt.m_xy[i].Set(i_, xy[i][i_ + i1_]);
    kdt.m_tags[i] = tags[i];
  }

  for (i_ = 0; i_ <= nx - 1; i_++)
    kdt.m_boxmin[i_] = kdt.m_xy[0][i_];
  for (i_ = 0; i_ <= nx - 1; i_++)
    kdt.m_boxmax[i_] = kdt.m_xy[0][i_];
  for (i = 1; i <= n - 1; i++) {
    for (j = 0; j <= nx - 1; j++) {
      kdt.m_boxmin[j] = MathMin(kdt.m_boxmin[j], kdt.m_xy[i][j]);
      kdt.m_boxmax[j] = MathMax(kdt.m_boxmax[j], kdt.m_xy[i][j]);
    }
  }

  maxnodes = n;

  ArrayResizeAL(kdt.m_nodes, m_splitnodesize * 2 * maxnodes);
  ArrayResizeAL(kdt.m_splits, 2 * maxnodes);
  nodesoffs = 0;
  splitsoffs = 0;
  for (i_ = 0; i_ <= nx - 1; i_++)
    kdt.m_curboxmin[i_] = kdt.m_boxmin[i_];
  for (i_ = 0; i_ <= nx - 1; i_++)
    kdt.m_curboxmax[i_] = kdt.m_boxmax[i_];

  KDTreeGenerateTreeRec(kdt, nodesoffs, splitsoffs, 0, n, 8);

  kdt.m_kcur = 0;
}

static int CNearestNeighbor::KDTreeQueryKNN(CKDTree &kdt, double &x[],
                                            const int k, const bool selfmatch) {

  if (!CAp::Assert(k >= 1, __FUNCTION__ + ": K<1!"))
    return (-1);

  if (!CAp::Assert(CAp::Len(x) >= kdt.m_nx, __FUNCTION__ + ": Length(X)<NX!"))
    return (-1);

  if (!CAp::Assert(CApServ::IsFiniteVector(x, kdt.m_nx),
                   __FUNCTION__ + ": X contains infinite or NaN values!"))
    return (-1);

  return (KDTreeQueryAKNN(kdt, x, k, selfmatch, 0.0));
}

static int CNearestNeighbor::KDTreeQueryRNN(CKDTree &kdt, double &x[],
                                            const double r,
                                            const bool selfmatch) {

  int result = 0;
  int i = 0;
  int j = 0;

  if (!CAp::Assert((double)(r) > 0.0, __FUNCTION__ + ": incorrect R!"))
    return (-1);

  if (!CAp::Assert(CAp::Len(x) >= kdt.m_nx, __FUNCTION__ + ": Length(X)<NX!"))
    return (-1);

  if (!CAp::Assert(CApServ::IsFiniteVector(x, kdt.m_nx),
                   __FUNCTION__ + ": X contains infinite or NaN values!"))
    return (-1);

  kdt.m_kneeded = 0;

  if (kdt.m_normtype != 2)
    kdt.m_rneeded = r;
  else
    kdt.m_rneeded = CMath::Sqr(r);

  kdt.m_selfmatch = selfmatch;
  kdt.m_approxf = 1;
  kdt.m_kcur = 0;

  KDTreeInitBox(kdt, x);

  KDTreeQueryNNRec(kdt, 0);

  result = kdt.m_kcur;
  j = kdt.m_kcur;
  for (i = kdt.m_kcur; i >= 2; i--)
    CTSort::TagHeapPopI(kdt.m_r, kdt.m_idx, j);

  return (result);
}

static int CNearestNeighbor::KDTreeQueryAKNN(CKDTree &kdt, double &x[], int k,
                                             const bool selfmatch,
                                             const double eps) {

  int result = 0;
  int i = 0;
  int j = 0;

  if (!CAp::Assert(k > 0, __FUNCTION__ + ": incorrect K!"))
    return (-1);

  if (!CAp::Assert(eps >= 0.0, __FUNCTION__ + ": incorrect Eps!"))
    return (-1);

  if (!CAp::Assert(CAp::Len(x) >= kdt.m_nx, __FUNCTION__ + ": Length(X)<NX!"))
    return (-1);

  if (!CAp::Assert(CApServ::IsFiniteVector(x, kdt.m_nx),
                   __FUNCTION__ + ": X contains infinite or NaN values!"))
    return (-1);

  k = MathMin(k, kdt.m_n);
  kdt.m_kneeded = k;
  kdt.m_rneeded = 0;
  kdt.m_selfmatch = selfmatch;

  if (kdt.m_normtype == 2)
    kdt.m_approxf = 1 / CMath::Sqr(1 + eps);
  else
    kdt.m_approxf = 1 / (1 + eps);
  kdt.m_kcur = 0;

  KDTreeInitBox(kdt, x);

  KDTreeQueryNNRec(kdt, 0);

  result = kdt.m_kcur;
  j = kdt.m_kcur;
  for (i = kdt.m_kcur; i >= 2; i--)
    CTSort::TagHeapPopI(kdt.m_r, kdt.m_idx, j);

  return (result);
}

static void CNearestNeighbor::KDTreeQueryResultsX(CKDTree &kdt,
                                                  CMatrixDouble &x) {

  int i = 0;
  int k = 0;
  int i_ = 0;
  int i1_ = 0;

  if (kdt.m_kcur == 0)
    return;

  if (CAp::Rows(x) < kdt.m_kcur || CAp::Cols(x) < kdt.m_nx)
    x.Resize(kdt.m_kcur, kdt.m_nx);

  k = kdt.m_kcur;
  for (i = 0; i <= k - 1; i++) {

    i1_ = kdt.m_nx;
    for (i_ = 0; i_ <= kdt.m_nx - 1; i_++)
      x[i].Set(i_, kdt.m_xy[kdt.m_idx[i]][i_ + i1_]);
  }
}

static void CNearestNeighbor::KDTreeQueryResultsXY(CKDTree &kdt,
                                                   CMatrixDouble &xy) {

  int i = 0;
  int k = 0;
  int i_ = 0;
  int i1_ = 0;

  if (kdt.m_kcur == 0)
    return;

  if (CAp::Rows(xy) < kdt.m_kcur || CAp::Cols(xy) < kdt.m_nx + kdt.m_ny)
    xy.Resize(kdt.m_kcur, kdt.m_nx + kdt.m_ny);

  k = kdt.m_kcur;
  for (i = 0; i <= k - 1; i++) {

    i1_ = kdt.m_nx;
    for (i_ = 0; i_ <= kdt.m_nx + kdt.m_ny - 1; i_++)
      xy[i].Set(i_, kdt.m_xy[kdt.m_idx[i]][i_ + i1_]);
  }
}

static void CNearestNeighbor::KDTreeQueryResultsTags(CKDTree &kdt,
                                                     int &tags[]) {

  int i = 0;
  int k = 0;

  if (kdt.m_kcur == 0)
    return;

  if (CAp::Len(tags) < kdt.m_kcur) {

    ArrayResizeAL(tags, kdt.m_kcur);
  }

  k = kdt.m_kcur;
  for (i = 0; i <= k - 1; i++)
    tags[i] = kdt.m_tags[kdt.m_idx[i]];
}

static void CNearestNeighbor::KDTreeQueryResultsDistances(CKDTree &kdt,
                                                          double &r[]) {

  int i = 0;
  int k = 0;

  if (kdt.m_kcur == 0)
    return;

  if (CAp::Len(r) < kdt.m_kcur) {

    ArrayResizeAL(r, kdt.m_kcur);
  }
  k = kdt.m_kcur;

  if (kdt.m_normtype == 0) {
    for (i = 0; i <= k - 1; i++)
      r[i] = MathAbs(kdt.m_r[i]);
  }

  if (kdt.m_normtype == 1) {
    for (i = 0; i <= k - 1; i++)
      r[i] = MathAbs(kdt.m_r[i]);
  }

  if (kdt.m_normtype == 2) {
    for (i = 0; i <= k - 1; i++)
      r[i] = MathSqrt(MathAbs(kdt.m_r[i]));
  }
}

static void CNearestNeighbor::KDTreeQueryResultsXI(CKDTree &kdt,
                                                   CMatrixDouble &x) {

  x.Resize(0, 0);

  KDTreeQueryResultsX(kdt, x);
}

static void CNearestNeighbor::KDTreeQueryResultsXYI(CKDTree &kdt,
                                                    CMatrixDouble &xy) {

  xy.Resize(0, 0);

  KDTreeQueryResultsXY(kdt, xy);
}

static void CNearestNeighbor::KDTreeQueryResultsTagsI(CKDTree &kdt,
                                                      int &tags[]) {

  ArrayResizeAL(tags, 0);

  KDTreeQueryResultsTags(kdt, tags);
}

static void CNearestNeighbor::KDTreeQueryResultsDistancesI(CKDTree &kdt,
                                                           double &r[]) {

  ArrayResizeAL(r, 0);

  KDTreeQueryResultsDistances(kdt, r);
}

static void CNearestNeighbor::KDTreeAlloc(CSerializer &s, CKDTree &tree) {

  s.Alloc_Entry();
  s.Alloc_Entry();

  s.Alloc_Entry();
  s.Alloc_Entry();
  s.Alloc_Entry();
  s.Alloc_Entry();

  CApServ::AllocRealMatrix(s, tree.m_xy, -1, -1);
  CApServ::AllocIntegerArray(s, tree.m_tags, -1);
  CApServ::AllocRealArray(s, tree.m_boxmin, -1);
  CApServ::AllocRealArray(s, tree.m_boxmax, -1);
  CApServ::AllocIntegerArray(s, tree.m_nodes, -1);
  CApServ::AllocRealArray(s, tree.m_splits, -1);
}

static void CNearestNeighbor::KDTreeSerialize(CSerializer &s, CKDTree &tree) {

  s.Serialize_Int(CSCodes::GetKDTreeSerializationCode());
  s.Serialize_Int(m_kdtreefirstversion);

  s.Serialize_Int(tree.m_n);
  s.Serialize_Int(tree.m_nx);
  s.Serialize_Int(tree.m_ny);
  s.Serialize_Int(tree.m_normtype);

  CApServ::SerializeRealMatrix(s, tree.m_xy, -1, -1);
  CApServ::SerializeIntegerArray(s, tree.m_tags, -1);
  CApServ::SerializeRealArray(s, tree.m_boxmin, -1);
  CApServ::SerializeRealArray(s, tree.m_boxmax, -1);
  CApServ::SerializeIntegerArray(s, tree.m_nodes, -1);
  CApServ::SerializeRealArray(s, tree.m_splits, -1);
}

static void CNearestNeighbor::KDTreeUnserialize(CSerializer &s, CKDTree &tree) {

  int i0 = 0;
  int i1 = 0;

  i0 = s.Unserialize_Int();

  if (!CAp::Assert(i0 == CSCodes::GetKDTreeSerializationCode(),
                   __FUNCTION__ + ": stream header corrupted"))
    return;
  i1 = s.Unserialize_Int();

  if (!CAp::Assert(i1 == m_kdtreefirstversion,
                   __FUNCTION__ + ": stream header corrupted"))
    return;

  tree.m_n = s.Unserialize_Int();
  tree.m_nx = s.Unserialize_Int();
  tree.m_ny = s.Unserialize_Int();
  tree.m_normtype = s.Unserialize_Int();

  CApServ::UnserializeRealMatrix(s, tree.m_xy);
  CApServ::UnserializeIntegerArray(s, tree.m_tags);
  CApServ::UnserializeRealArray(s, tree.m_boxmin);
  CApServ::UnserializeRealArray(s, tree.m_boxmax);
  CApServ::UnserializeIntegerArray(s, tree.m_nodes);
  CApServ::UnserializeRealArray(s, tree.m_splits);

  KDTreeAllocTemporaries(tree, tree.m_n, tree.m_nx, tree.m_ny);
}

static void CNearestNeighbor::KDTreeSplit(CKDTree &kdt, const int i1,
                                          const int i2, const int d,
                                          const double s, int &i3) {

  int i = 0;
  int j = 0;
  int ileft = 0;
  int iright = 0;
  double v = 0;

  i3 = 0;

  ileft = i1;
  iright = i2 - 1;
  while (ileft < iright) {

    if (kdt.m_xy[ileft][d] <= s) {

      ileft = ileft + 1;
    } else {

      for (i = 0; i <= 2 * kdt.m_nx + kdt.m_ny - 1; i++) {
        v = kdt.m_xy[ileft][i];
        kdt.m_xy[ileft].Set(i, kdt.m_xy[iright][i]);
        kdt.m_xy[iright].Set(i, v);
      }

      j = kdt.m_tags[ileft];
      kdt.m_tags[ileft] = kdt.m_tags[iright];
      kdt.m_tags[iright] = j;
      iright = iright - 1;
    }
  }

  if (kdt.m_xy[ileft][d] <= s)
    ileft = ileft + 1;
  else
    iright = iright - 1;

  i3 = ileft;
}

static void CNearestNeighbor::KDTreeGenerateTreeRec(CKDTree &kdt,
                                                    int &nodesoffs,
                                                    int &splitsoffs,
                                                    const int i1, const int i2,
                                                    const int maxleafsize) {

  int n = 0;
  int nx = 0;
  int ny = 0;
  int i = 0;
  int j = 0;
  int oldoffs = 0;
  int i3 = 0;
  int cntless = 0;
  int cntgreater = 0;
  double minv = 0;
  double maxv = 0;
  int minidx = 0;
  int maxidx = 0;
  int d = 0;
  double ds = 0;
  double s = 0;
  double v = 0;
  int i_ = 0;
  int i1_ = 0;

  if (!CAp::Assert(i2 > i1, __FUNCTION__ + ": internal error"))
    return;

  if (i2 - i1 <= maxleafsize) {
    kdt.m_nodes[nodesoffs + 0] = i2 - i1;
    kdt.m_nodes[nodesoffs + 1] = i1;
    nodesoffs = nodesoffs + 2;

    return;
  }

  nx = kdt.m_nx;
  ny = kdt.m_ny;

  d = 0;
  ds = kdt.m_curboxmax[0] - kdt.m_curboxmin[0];
  for (i = 1; i <= nx - 1; i++) {
    v = kdt.m_curboxmax[i] - kdt.m_curboxmin[i];

    if (v > ds) {
      ds = v;
      d = i;
    }
  }

  s = kdt.m_curboxmin[d] + 0.5 * ds;
  i1_ = (i1) - (0);
  for (i_ = 0; i_ <= i2 - i1 - 1; i_++)
    kdt.m_buf[i_] = kdt.m_xy[i_ + i1_][d];

  n = i2 - i1;
  cntless = 0;
  cntgreater = 0;
  minv = kdt.m_buf[0];
  maxv = kdt.m_buf[0];
  minidx = i1;
  maxidx = i1;
  for (i = 0; i <= n - 1; i++) {
    v = kdt.m_buf[i];

    if (v < minv) {
      minv = v;
      minidx = i1 + i;
    }

    if (v > maxv) {
      maxv = v;
      maxidx = i1 + i;
    }

    if (v < s)
      cntless = cntless + 1;

    if (v > s)
      cntgreater = cntgreater + 1;
  }

  if (cntless > 0 && cntgreater > 0) {

    KDTreeSplit(kdt, i1, i2, d, s, i3);
  } else {

    if (cntless == 0) {

      s = minv;

      if (minidx != i1) {
        for (i = 0; i <= 2 * kdt.m_nx + kdt.m_ny - 1; i++) {
          v = kdt.m_xy[minidx][i];
          kdt.m_xy[minidx].Set(i, kdt.m_xy[i1][i]);
          kdt.m_xy[i1].Set(i, v);
        }

        j = kdt.m_tags[minidx];
        kdt.m_tags[minidx] = kdt.m_tags[i1];
        kdt.m_tags[i1] = j;
      }
      i3 = i1 + 1;
    } else {

      s = maxv;

      if (maxidx != i2 - 1) {
        for (i = 0; i <= 2 * kdt.m_nx + kdt.m_ny - 1; i++) {
          v = kdt.m_xy[maxidx][i];
          kdt.m_xy[maxidx].Set(i, kdt.m_xy[i2 - 1][i]);
          kdt.m_xy[i2 - 1].Set(i, v);
        }

        j = kdt.m_tags[maxidx];
        kdt.m_tags[maxidx] = kdt.m_tags[i2 - 1];
        kdt.m_tags[i2 - 1] = j;
      }
      i3 = i2 - 1;
    }
  }

  kdt.m_nodes[nodesoffs + 0] = 0;
  kdt.m_nodes[nodesoffs + 1] = d;
  kdt.m_nodes[nodesoffs + 2] = splitsoffs;
  kdt.m_splits[splitsoffs + 0] = s;
  oldoffs = nodesoffs;
  nodesoffs = nodesoffs + m_splitnodesize;
  splitsoffs = splitsoffs + 1;

  kdt.m_nodes[oldoffs + 3] = nodesoffs;
  v = kdt.m_curboxmax[d];
  kdt.m_curboxmax[d] = s;

  KDTreeGenerateTreeRec(kdt, nodesoffs, splitsoffs, i1, i3, maxleafsize);
  kdt.m_curboxmax[d] = v;
  kdt.m_nodes[oldoffs + 4] = nodesoffs;
  v = kdt.m_curboxmin[d];
  kdt.m_curboxmin[d] = s;

  KDTreeGenerateTreeRec(kdt, nodesoffs, splitsoffs, i3, i2, maxleafsize);
  kdt.m_curboxmin[d] = v;
}

static void CNearestNeighbor::KDTreeQueryNNRec(CKDTree &kdt, const int offs) {

  double ptdist = 0;
  int i = 0;
  int j = 0;
  int nx = 0;
  int i1 = 0;
  int i2 = 0;
  int d = 0;
  double s = 0;
  double v = 0;
  double t1 = 0;
  int childbestoffs = 0;
  int childworstoffs = 0;
  int childoffs = 0;
  double prevdist = 0;
  bool todive;
  bool bestisleft;
  bool updatemin;

  if (kdt.m_nodes[offs] > 0) {
    i1 = kdt.m_nodes[offs + 1];
    i2 = i1 + kdt.m_nodes[offs];
    for (i = i1; i <= i2 - 1; i++) {

      ptdist = 0;
      nx = kdt.m_nx;

      if (kdt.m_normtype == 0) {
        for (j = 0; j <= nx - 1; j++)
          ptdist = MathMax(ptdist, MathAbs(kdt.m_xy[i][j] - kdt.m_x[j]));
      }

      if (kdt.m_normtype == 1) {
        for (j = 0; j <= nx - 1; j++)
          ptdist = ptdist + MathAbs(kdt.m_xy[i][j] - kdt.m_x[j]);
      }

      if (kdt.m_normtype == 2) {
        for (j = 0; j <= nx - 1; j++)
          ptdist = ptdist + CMath::Sqr(kdt.m_xy[i][j] - kdt.m_x[j]);
      }

      if (ptdist == 0.0 && !kdt.m_selfmatch)
        continue;

      if (kdt.m_rneeded == 0.0 || ptdist <= kdt.m_rneeded) {

        if (kdt.m_kcur < kdt.m_kneeded || kdt.m_kneeded == 0) {

          CTSort::TagHeapPushI(kdt.m_r, kdt.m_idx, kdt.m_kcur, ptdist, i);
        } else {

          if (ptdist < (double)(kdt.m_r[0])) {

            if (kdt.m_kneeded == 1) {
              kdt.m_idx[0] = i;
              kdt.m_r[0] = ptdist;
            } else
              CTSort::TagHeapReplaceTopI(kdt.m_r, kdt.m_idx, kdt.m_kneeded,
                                         ptdist, i);
          }
        }
      }
    }

    return;
  }

  if (kdt.m_nodes[offs] == 0) {

    d = kdt.m_nodes[offs + 1];
    s = kdt.m_splits[kdt.m_nodes[offs + 2]];

    if (kdt.m_x[d] <= s) {
      childbestoffs = kdt.m_nodes[offs + 3];
      childworstoffs = kdt.m_nodes[offs + 4];
      bestisleft = true;
    } else {
      childbestoffs = kdt.m_nodes[offs + 4];
      childworstoffs = kdt.m_nodes[offs + 3];
      bestisleft = false;
    }

    for (i = 0; i <= 1; i++) {

      if (i == 0) {
        childoffs = childbestoffs;
        updatemin = !bestisleft;
      } else {
        updatemin = bestisleft;
        childoffs = childworstoffs;
      }

      if (updatemin) {
        prevdist = kdt.m_curdist;
        t1 = kdt.m_x[d];
        v = kdt.m_curboxmin[d];

        if (t1 <= s) {

          if (kdt.m_normtype == 0)
            kdt.m_curdist = MathMax(kdt.m_curdist, s - t1);

          if (kdt.m_normtype == 1)
            kdt.m_curdist = kdt.m_curdist - MathMax(v - t1, 0) + s - t1;

          if (kdt.m_normtype == 2)
            kdt.m_curdist = kdt.m_curdist - CMath::Sqr(MathMax(v - t1, 0)) +
                            CMath::Sqr(s - t1);
        }
        kdt.m_curboxmin[d] = s;
      } else {
        prevdist = kdt.m_curdist;
        t1 = kdt.m_x[d];
        v = kdt.m_curboxmax[d];

        if (t1 >= s) {

          if (kdt.m_normtype == 0)
            kdt.m_curdist = MathMax(kdt.m_curdist, t1 - s);

          if (kdt.m_normtype == 1)
            kdt.m_curdist = kdt.m_curdist - MathMax(t1 - v, 0) + t1 - s;

          if (kdt.m_normtype == 2)
            kdt.m_curdist = kdt.m_curdist - CMath::Sqr(MathMax(t1 - v, 0)) +
                            CMath::Sqr(t1 - s);
        }
        kdt.m_curboxmax[d] = s;
      }

      if (kdt.m_rneeded != 0.0 && kdt.m_curdist > kdt.m_rneeded)
        todive = false;
      else {

        if (kdt.m_kcur < kdt.m_kneeded || kdt.m_kneeded == 0) {

          todive = true;
        } else {

          todive = kdt.m_curdist <= (double)(kdt.m_r[0] * kdt.m_approxf);
        }
      }

      if (todive)
        KDTreeQueryNNRec(kdt, childoffs);

      if (updatemin)
        kdt.m_curboxmin[d] = v;
      else
        kdt.m_curboxmax[d] = v;
      kdt.m_curdist = prevdist;
    }

    return;
  }
}

static void CNearestNeighbor::KDTreeInitBox(CKDTree &kdt, double &x[]) {

  int i = 0;
  double vx = 0;
  double vmin = 0;
  double vmax = 0;

  kdt.m_curdist = 0;

  if (kdt.m_normtype == 0) {
    for (i = 0; i <= kdt.m_nx - 1; i++) {
      vx = x[i];
      vmin = kdt.m_boxmin[i];
      vmax = kdt.m_boxmax[i];
      kdt.m_x[i] = vx;
      kdt.m_curboxmin[i] = vmin;
      kdt.m_curboxmax[i] = vmax;

      if (vx < vmin)
        kdt.m_curdist = MathMax(kdt.m_curdist, vmin - vx);
      else {

        if (vx > vmax)
          kdt.m_curdist = MathMax(kdt.m_curdist, vx - vmax);
      }
    }
  }

  if (kdt.m_normtype == 1) {
    for (i = 0; i <= kdt.m_nx - 1; i++) {
      vx = x[i];
      vmin = kdt.m_boxmin[i];
      vmax = kdt.m_boxmax[i];
      kdt.m_x[i] = vx;
      kdt.m_curboxmin[i] = vmin;
      kdt.m_curboxmax[i] = vmax;

      if (vx < vmin)
        kdt.m_curdist = kdt.m_curdist + vmin - vx;
      else {

        if (vx > vmax)
          kdt.m_curdist = kdt.m_curdist + vx - vmax;
      }
    }
  }

  if (kdt.m_normtype == 2) {
    for (i = 0; i <= kdt.m_nx - 1; i++) {
      vx = x[i];
      vmin = kdt.m_boxmin[i];
      vmax = kdt.m_boxmax[i];
      kdt.m_x[i] = vx;
      kdt.m_curboxmin[i] = vmin;
      kdt.m_curboxmax[i] = vmax;

      if (vx < vmin)
        kdt.m_curdist = kdt.m_curdist + CMath::Sqr(vmin - vx);
      else {

        if (vx > vmax)
          kdt.m_curdist = kdt.m_curdist + CMath::Sqr(vx - vmax);
      }
    }
  }
}

static void CNearestNeighbor::KDTreeAllocDataSetIndependent(CKDTree &kdt,
                                                            const int nx,
                                                            const int ny) {

  ArrayResizeAL(kdt.m_x, nx);
  ArrayResizeAL(kdt.m_boxmin, nx);
  ArrayResizeAL(kdt.m_boxmax, nx);
  ArrayResizeAL(kdt.m_curboxmin, nx);
  ArrayResizeAL(kdt.m_curboxmax, nx);
}

static void CNearestNeighbor::KDTreeAllocDataSetDependent(CKDTree &kdt,
                                                          const int n,
                                                          const int nx,
                                                          const int ny) {

  kdt.m_xy.Resize(n, 2 * nx + ny);
  ArrayResizeAL(kdt.m_tags, n);
  ArrayResizeAL(kdt.m_idx, n);
  ArrayResizeAL(kdt.m_r, n);
  ArrayResizeAL(kdt.m_x, nx);
  ArrayResizeAL(kdt.m_buf, MathMax(n, nx));
  ArrayResizeAL(kdt.m_nodes, m_splitnodesize * 2 * n);
  ArrayResizeAL(kdt.m_splits, 2 * n);
}

static void CNearestNeighbor::KDTreeAllocTemporaries(CKDTree &kdt, const int n,
                                                     const int nx,
                                                     const int ny) {

  ArrayResizeAL(kdt.m_x, nx);
  ArrayResizeAL(kdt.m_idx, n);
  ArrayResizeAL(kdt.m_r, n);
  ArrayResizeAL(kdt.m_buf, MathMax(n, nx));
  ArrayResizeAL(kdt.m_curboxmin, nx);
  ArrayResizeAL(kdt.m_curboxmax, nx);
}

#endif
