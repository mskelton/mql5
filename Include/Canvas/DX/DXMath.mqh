#ifndef DXMATH_H
#define DXMATH_H

#define DX_PI 3.1415926535897932384626f
#define DX_PI_DIV2 1.5707963267948966192313f
#define DX_PI_DIV3 1.0471975511965977461542f
#define DX_PI_DIV4 0.7853981633974483096156f
#define DX_PI_DIV6 0.5235987755982988730771f
#define DX_PI_MUL2 6.2831853071795864769253f
#define DXSH_MINORDER 2
#define DXSH_MAXORDER 6

struct DXColor;
struct DXPlane;
struct DXVector2;
struct DXVector3;
struct DXVector4;
struct DXMatrix;
struct DXQuaternion;
struct DViewport;

struct DXColor {
  float r;
  float g;
  float b;
  float a;

  DXColor(void);
  DXColor(float red, float green, float blue, float alpha);
  DXColor(const DXVector4 &v);
  DXColor(const DXVector3 &v);
};

struct DXPlane {
  float a;
  float b;
  float c;
  float d;
};

struct DXVector2 {
  float x;
  float y;

  DXVector2(void);
  DXVector2(float v);
  DXVector2(float vx, float vy);
  DXVector2(const DXVector3 &v);
  DXVector2(const DXVector4 &v);
};

struct DXVector3 {
  float x;
  float y;
  float z;

  DXVector3(void);
  DXVector3(float v);
  DXVector3(float vx, float vy, float vz);
  DXVector3(const DXVector2 &v);
  DXVector3(const DXVector4 &v);
};

struct DXVector4 {
  float x;
  float y;
  float z;
  float w;

  DXVector4(void);
  DXVector4(float v);
  DXVector4(float vx, float vy, float vz, float vw);
  DXVector4(const DXVector2 &v);
  DXVector4(const DXVector3 &v);
};

struct DXMatrix {
  float m[4][4];
};

struct DXQuaternion {
  float x;
  float y;
  float z;
  float w;
};

struct DViewport {
  ulong x;
  ulong y;
  ulong width;
  ulong height;
  float minz;
  float maxz;
};

/*

void  DXColorAdd(DXColor &pout,const DXColor &pc1,const DXColor &pc2);
void  DXColorAdjustContrast(DXColor &pout,const DXColor &pc,float s);
void  DXColorAdjustSaturation(DXColor &pout,const DXColor &pc,float s);
void  DXColorLerp(DXColor &pout,const DXColor &pc1,const DXColor &pc2,float s);
void  DXColorModulate(DXColor &pout,const DXColor &pc1,const DXColor &pc2);
void  DXColorNegative(DXColor &pout,const DXColor &pc);
void  DXColorScale(DXColor &pout,const DXColor &pc,float s);
void  DXColorSubtract(DXColor &pout,const DXColor &pc1,const DXColor &pc2);
float DXFresnelTerm(float costheta,float refractionindex);


void  DXVec2Add(DXVector2 &pout,const DXVector2 &pv1,const DXVector2 &pv2);
void  DXVec2BaryCentric(DXVector2 &pout,const DXVector2 &pv1,const DXVector2
&pv2,const DXVector2 &pv3,float f,float g); void  DXVec2CatmullRom(DXVector2
&pout,const DXVector2 &pv0,const DXVector2 &pv1,const DXVector2 &pv2,const
DXVector2 &pv3,float s); float DXVec2CCW(const DXVector2 &pv1,const DXVector2
&pv2); float DXVec2Dot(const DXVector2 &pv1,const DXVector2 &pv2); void
DXVec2Hermite(DXVector2 &pout,const DXVector2 &pv1,const DXVector2 &pt1,const
DXVector2 &pv2,const DXVector2 &pt2,float s); float DXVec2Length(const DXVector2
&v); float DXVec2LengthSq(const DXVector2 &v); void  DXVec2Lerp(DXVector2
&pout,const DXVector2 &pv1,const DXVector2 &pv2,float s); void
DXVec2Maximize(DXVector2 &pout,const DXVector2 &pv1,const DXVector2 &pv2); void
DXVec2Minimize(DXVector2 &pout,const DXVector2 &pv1,const DXVector2 &pv2); void
DXVec2Normalize(DXVector2 &pout,const DXVector2 &pv); void DXVec2Scale(DXVector2
&pout,const DXVector2 &pv,float s); void  DXVec2Subtract(DXVector2 &pout,const
DXVector2 &pv1,const DXVector2 &pv2); void  DXVec2Transform(DXVector4
&pout,const DXVector2 &pv,const DXMatrix &pm); void
DXVec2TransformCoord(DXVector2 &pout,const DXVector2 &pv,const DXMatrix &pm);
void  DXVec2TransformNormal(DXVector2 &pout,const DXVector2 &pv,const DXMatrix
&pm);


void  DXVec3Add(DXVector3 &pout,const DXVector3 &pv1,const DXVector3 &pv2);
void  DXVec3BaryCentric(DXVector3 &pout,const DXVector3 &pv1,const DXVector3
&pv2,const DXVector3 &pv3,float f,float g); void  DXVec3CatmullRom(DXVector3
&pout,const DXVector3 &pv0,const DXVector3 &pv1,const DXVector3 &pv2,const
DXVector3 &pv3,float s); void  DXVec3Cross(DXVector3 &pout,const DXVector3
&pv1,const DXVector3 &pv2); float DXVec3Dot(const DXVector3 &pv1,const DXVector3
&pv2); void  DXVec3Hermite(DXVector3 &pout,const DXVector3 &pv1,const DXVector3
&pt1,const DXVector3 &pv2,const DXVector3 &pt2,float s); float
DXVec3Length(const DXVector3 &pv); float DXVec3LengthSq(const DXVector3 &pv);
void  DXVec3Lerp(DXVector3 &pout,const DXVector3 &pv1,const DXVector3 &pv2,float
s); void  DXVec3Maximize(DXVector3 &pout,const DXVector3 &pv1,const DXVector3
&pv2); void  DXVec3Minimize(DXVector3 &pout,const DXVector3 &pv1,const DXVector3
&pv2); void  DXVec3Normalize(DXVector3 &pout,const DXVector3 &pv); void
DXVec3Project(DXVector3 &pout,const DXVector3 &pv,const DViewport
&pviewport,const DXMatrix &pprojection,const DXMatrix &pview,const DXMatrix
&pworld); void  DXVec3Scale(DXVector3 &pout,const DXVector3 &pv,float s); void
DXVec3Subtract(DXVector3 &pout,const DXVector3 &pv1,const DXVector3 &pv2); void
DXVec3Transform(DXVector4 &pout,const DXVector3 &pv,const DXMatrix &pm); void
DXVec3TransformCoord(DXVector3 &pout,const DXVector3 &pv,const DXMatrix &pm);
void  DXVec3TransformNormal(DXVector3 &pout,const DXVector3 &pv,const DXMatrix
&pm); void  DXVec3Unproject(DXVector3 &out,const DXVector3 &v,const DViewport
&viewport,const DXMatrix &projection,const DXMatrix &view,const DXMatrix
&world);


void  DXVec4Add(DXVector4 &pout,const DXVector4 &pv1,const DXVector4 &pv2);
void  DXVec4BaryCentric(DXVector4 &pout,const DXVector4 &pv1,const DXVector4
&pv2,const DXVector4 &pv3,float f,float g); void  DXVec4CatmullRom(DXVector4
&pout,const DXVector4 &pv0,const DXVector4 &pv1,const DXVector4 &pv2,const
DXVector4 &pv3,float s); void  DXVec4Cross(DXVector4 &pout,const DXVector4
&pv1,const DXVector4 &pv2,const DXVector4 &pv3); float DXVec4Dot(const DXVector4
&pv1,const DXVector4 &pv2); void  DXVec4Hermite(DXVector4 &pout,const DXVector4
&pv1,const DXVector4 &pt1,const DXVector4 &pv2,const DXVector4 &pt2,float s);
float DXVec4Length(const DXVector4 &pv);
float DXVec4LengthSq(const DXVector4 &pv);
void  DXVec4Lerp(DXVector4 &pout,const DXVector4 &pv1,const DXVector4 &pv2,float
s); void  DXVec4Maximize(DXVector4 &pout,const DXVector4 &pv1,const DXVector4
&pv2); void  DXVec4Minimize(DXVector4 &pout,const DXVector4 &pv1,const DXVector4
&pv2); void  DXVec4Normalize(DXVector4 &pout,const DXVector4 &pv); void
DXVec4Scale(DXVector4 &pout,const DXVector4 &pv,float s); void
DXVec4Subtract(DXVector4 &pout,const DXVector4 &pv1,const DXVector4 &pv2); void
DXVec4Transform(DXVector4 &pout,const DXVector4 &pv,const DXMatrix &pm);


void  DXQuaternionBaryCentric(DXQuaternion &pout,DXQuaternion &pq1,DXQuaternion
&pq2,DXQuaternion &pq3,float f,float g); void DXQuaternionConjugate(DXQuaternion
&pout,const DXQuaternion &pq); float DXQuaternionDot(DXQuaternion
&a,DXQuaternion &b); void  DXQuaternionExp(DXQuaternion &out,const DXQuaternion
&q); void  DXQuaternionIdentity(DXQuaternion &out); bool
DXQuaternionIsIdentity(DXQuaternion &pq); float DXQuaternionLength(const
DXQuaternion &pq); float DXQuaternionLengthSq(const DXQuaternion &pq); void
DXQuaternionInverse(DXQuaternion &pout,const DXQuaternion &pq); void
DXQuaternionLn(DXQuaternion &out,const DXQuaternion &q); void
DXQuaternionMultiply(DXQuaternion &pout,const DXQuaternion &pq1,const
DXQuaternion &pq2); void  DXQuaternionNormalize(DXQuaternion &out,const
DXQuaternion &q); void  DXQuaternionRotationAxis(DXQuaternion &out,const
DXVector3 &v,float angle); void  DXQuaternionRotationMatrix(DXQuaternion
&out,const DXMatrix &m); void  DXQuaternionRotationYawPitchRoll(DXQuaternion
&out,float yaw,float pitch,float roll); void  DXQuaternionSlerp(DXQuaternion
&out,DXQuaternion &q1,DXQuaternion &q2,float t); void
DXQuaternionSquad(DXQuaternion &pout,DXQuaternion &pq1,DXQuaternion
&pq2,DXQuaternion &pq3,DXQuaternion &pq4,float t); void
DXQuaternionSquadSetup(DXQuaternion &paout,DXQuaternion &pbout,DXQuaternion
&pcout,DXQuaternion &pq0,DXQuaternion &pq1,DXQuaternion &pq2,DXQuaternion &pq3);
void  DXQuaternionToAxisAngle(const DXQuaternion &pq,DXVector3 &paxis,float
&pangle); DXQuaternion add_diff(const DXQuaternion &q1,const DXQuaternion
&q2,const float add);


void  DXMatrixIdentity(DXMatrix &out);
bool  DXMatrixIsIdentity(DXMatrix &pm);
void  DXMatrixAffineTransformation(DXMatrix &out,float scaling,const DXVector3
&rotationcenter,const DXQuaternion &rotation,const DXVector3 &translation); void
DXMatrixAffineTransformation2D(DXMatrix &out,float scaling,const DXVector2
&rotationcenter,float rotation,const DXVector2 &translation); int
DXMatrixDecompose(DXVector3 &poutscale,DXQuaternion &poutrotation,DXVector3
&pouttranslation,const DXMatrix &pm); float DXMatrixDeterminant(const DXMatrix
&pm); void  DXMatrixInverse(DXMatrix &pout,float &pdeterminant,const DXMatrix
&pm); void  DXMatrixLookAtLH(DXMatrix &out,const DXVector3 &eye,const DXVector3
&at,const DXVector3 &up); void  DXMatrixLookAtRH(DXMatrix &out,const DXVector3
&eye,const DXVector3 &at,const DXVector3 &up); void  DXMatrixMultiply(DXMatrix
&pout,const DXMatrix &pm1,const DXMatrix &pm2); void
DXMatrixMultiplyTranspose(DXMatrix &pout,const DXMatrix &pm1,const DXMatrix
&pm2); void  DXMatrixOrthoLH(DXMatrix &pout,float w,float h,float zn,float zf);
void  DXMatrixOrthoOffCenterLH(DXMatrix &pout,float l,float r,float b,float
t,float zn,float zf); void  DXMatrixOrthoOffCenterRH(DXMatrix &pout,float
l,float r,float b,float t,float zn,float zf); void  DXMatrixOrthoRH(DXMatrix
&pout,float w,float h,float zn,float zf); void DXMatrixPerspectiveFovLH(DXMatrix
&pout,float fovy,float aspect,float zn,float zf); void
DXMatrixPerspectiveFovRH(DXMatrix &pout,float fovy,float aspect,float zn,float
zf); void  DXMatrixPerspectiveLH(DXMatrix &pout,float w,float h,float zn,float
zf); void  DXMatrixPerspectiveOffCenterLH(DXMatrix &pout,float l,float r,float
b,float t,float zn,float zf); void  DXMatrixPerspectiveOffCenterRH(DXMatrix
&pout,float l,float r,float b,float t,float zn,float zf); void
DXMatrixPerspectiveRH(DXMatrix &pout,float w,float h,float zn,float zf); void
DXMatrixReflect(DXMatrix &pout,const DXPlane &pplane); void
DXMatrixRotationAxis(DXMatrix &out,const DXVector3 &v,float angle); void
DXMatrixRotationQuaternion(DXMatrix &pout,const DXQuaternion &pq); void
DXMatrixRotationX(DXMatrix &pout,float angle); void  DXMatrixRotationY(DXMatrix
&pout,float angle); void  DXMatrixRotationYawPitchRoll(DXMatrix &out,float
yaw,float pitch,float roll); void  DXMatrixRotationZ(DXMatrix &pout,float
angle); void  DXMatrixScaling(DXMatrix &pout,float sx,float sy,float sz); void
DXMatrixShadow(DXMatrix &pout,const DXVector4 &plight,const DXPlane &pplane);
void  DXMatrixTransformation(DXMatrix &pout,const DXVector3
&pscalingcenter,const DXQuaternion &pscalingrotation,const DXVector3
&pscaling,const DXVector3 &protationcenter,const DXQuaternion &protation,const
DXVector3 &ptranslation); void  DXMatrixTransformation2D(DXMatrix &pout,const
DXVector2 &pscalingcenter,float scalingrotation,const DXVector2 &pscaling,const
DXVector2 &protationcenter,float rotation,const DXVector2 &ptranslation); void
DXMatrixTranslation(DXMatrix &pout,float x,float y,float z); void
DXMatrixTranspose(DXMatrix &pout,const DXMatrix &pm);


float DXPlaneDot(const DXPlane &p1,const DXVector4 &p2);
float DXPlaneDotCoord(const DXPlane &pp,const DXVector4 &pv);
float DXPlaneDotNormal(const DXPlane &pp,const DXVector4 &pv);
void  DXPlaneFromPointNormal(DXPlane &pout,const DXVector3 &pvpoint,const
DXVector3 &pvnormal); void  DXPlaneFromPoints(DXPlane &pout,const DXVector3
&pv1,const DXVector3 &pv2,const DXVector3 &pv3); void
DXPlaneIntersectLine(DXVector3 &pout,const DXPlane &pp,const DXVector3
&pv1,const DXVector3 &pv2); void  DXPlaneNormalize(DXPlane &out,const DXPlane
&p); void  DXPlaneScale(DXPlane &pout,const DXPlane &p,float s); void
DXPlaneTransform(DXPlane &pout,const DXPlane &pplane,const DXMatrix &pm);


void  DXSHAdd(float out[],int order,const float a[],const float b[]);
float DXSHDot(int order,const float a[],const float b[]);
int   DXSHEvalConeLight(int order,const DXVector3 &dir,float radius,float
Rintensity,float Gintensity,float Bintensity,float rout[],float gout[],float
bout[]); void  DXSHEvalDirection(float out[],int order,const DXVector3 &dir);
int   DXSHEvalDirectionalLight(int order,const DXVector3 &dir,float
Rintensity,float Gintensity,float Bintensity,float rout[],float gout[],float
bout[]); int   DXSHEvalHemisphereLight(int order,const DXVector3 &dir,DXColor
top,DXColor &bottom,float &rout[],float gout[],float bout[]); int
DXSHEvalSphericalLight(int order,const DXVector3 &dir,float radius,float
Rintensity,float Gintensity,float Bintensity,float rout[],float gout[],float
bout[]); void  DXSHMultiply2(float out[],const float a[],const float b[]);
void  DXSHMultiply3(float out[],const float a[],const float b[]);
void  DXSHMultiply4(float out[],const float a[],const float b[]);
void  DXSHRotate(float out[],int order,const DXMatrix &matrix,const float
in[]); void  DXSHRotateZ(float out[],int order,float angle,const float in[]);
void  DXSHScale(float out[],int order,const float a[],const float scale);


float DXScalarLerp(const float val1,const float val2,float s)
float DXScalarBiasScale(const float val,const float bias,const float scale)
*/

void DXColorAdd(DXColor &pout, const DXColor &pc1, const DXColor &pc2);

void DXColorAdjustContrast(DXColor &pout, const DXColor &pc, float s);

void DXColorAdjustSaturation(DXColor &pout, const DXColor &pc, float s);

void DXColorLerp(DXColor &pout, const DXColor &pc1, const DXColor &pc2,
                 float s);

void DXColorModulate(DXColor &pout, const DXColor &pc1, const DXColor &pc2);

void DXColorNegative(DXColor &pout, const DXColor &pc);

void DXColorScale(DXColor &pout, const DXColor &pc, float s);

void DXColorSubtract(DXColor &pout, const DXColor &pc1, const DXColor &pc2);

float DXFresnelTerm(float costheta, float refractionindex);

void DXVec2Add(DXVector2 &pout, const DXVector2 &pv1, const DXVector2 &pv2);

void DXVec2BaryCentric(DXVector2 &pout, const DXVector2 &pv1,
                       const DXVector2 &pv2, const DXVector2 &pv3, float f,
                       float g);

void DXVec2CatmullRom(DXVector2 &pout, const DXVector2 &pv0,
                      const DXVector2 &pv1, const DXVector2 &pv2,
                      const DXVector2 &pv3, float s);

float DXVec2CCW(const DXVector2 &pv1, const DXVector2 &pv2);

float DXVec2Dot(const DXVector2 &pv1, const DXVector2 &pv2);

void DXVec2Hermite(DXVector2 &pout, const DXVector2 &pv1, const DXVector2 &pt1,
                   const DXVector2 &pv2, const DXVector2 &pt2, float s);

float DXVec2Length(const DXVector2 &v);

float DXVec2LengthSq(const DXVector2 &v);

void DXVec2Lerp(DXVector2 &pout, const DXVector2 &pv1, const DXVector2 &pv2,
                float s);

void DXVec2Maximize(DXVector2 &pout, const DXVector2 &pv1,
                    const DXVector2 &pv2);

void DXVec2Minimize(DXVector2 &pout, const DXVector2 &pv1,
                    const DXVector2 &pv2);

void DXVec2Normalize(DXVector2 &pout, const DXVector2 &pv);

void DXVec2Scale(DXVector2 &pout, const DXVector2 &pv, float s);

void DXVec2Subtract(DXVector2 &pout, const DXVector2 &pv1,
                    const DXVector2 &pv2);

void DXVec2Transform(DXVector4 &pout, const DXVector2 &pv, const DXMatrix &pm);

void DXVec2TransformCoord(DXVector2 &pout, const DXVector2 &pv,
                          const DXMatrix &pm);

void DXVec2TransformNormal(DXVector2 &pout, const DXVector2 &pv,
                           const DXMatrix &pm);

void DXVec3Add(DXVector3 &pout, const DXVector3 &pv1, const DXVector3 &pv2);

void DXVec3BaryCentric(DXVector3 &pout, const DXVector3 &pv1,
                       const DXVector3 &pv2, const DXVector3 &pv3, float f,
                       float g);

void DXVec3CatmullRom(DXVector3 &pout, const DXVector3 &pv0,
                      const DXVector3 &pv1, const DXVector3 &pv2,
                      const DXVector3 &pv3, float s);

void DXVec3Cross(DXVector3 &pout, const DXVector3 &pv1, const DXVector3 &pv2);

float DXVec3Dot(const DXVector3 &pv1, const DXVector3 &pv2);

void DXVec3Hermite(DXVector3 &pout, const DXVector3 &pv1, const DXVector3 &pt1,
                   const DXVector3 &pv2, const DXVector3 &pt2, float s);

float DXVec3Length(const DXVector3 &pv);

float DXVec3LengthSq(const DXVector3 &pv);

void DXVec3Lerp(DXVector3 &pout, const DXVector3 &pv1, const DXVector3 &pv2,
                float s);

void DXVec3Maximize(DXVector3 &pout, const DXVector3 &pv1,
                    const DXVector3 &pv2);

void DXVec3Minimize(DXVector3 &pout, const DXVector3 &pv1,
                    const DXVector3 &pv2);

void DXVec3Normalize(DXVector3 &pout, const DXVector3 &pv);

void DXVec3Project(DXVector3 &pout, const DXVector3 &pv,
                   const DViewport &pviewport, const DXMatrix &pprojection,
                   const DXMatrix &pview, const DXMatrix &pworld);

void DXVec3Scale(DXVector3 &pout, const DXVector3 &pv, float s);

void DXVec3Subtract(DXVector3 &pout, const DXVector3 &pv1,
                    const DXVector3 &pv2);

void DXVec3Transform(DXVector4 &pout, const DXVector3 &pv, const DXMatrix &pm);

void DXVec3TransformCoord(DXVector3 &pout, const DXVector3 &pv,
                          const DXMatrix &pm);

void DXVec3TransformNormal(DXVector3 &pout, const DXVector3 &pv,
                           const DXMatrix &pm);

void DXVec3Unproject(DXVector3 &out, const DXVector3 &v,
                     const DViewport &viewport, const DXMatrix &projection,
                     const DXMatrix &view, const DXMatrix &world);

void DXVec4Add(DXVector4 &pout, const DXVector4 &pv1, const DXVector4 &pv2);

void DXVec4BaryCentric(DXVector4 &pout, const DXVector4 &pv1,
                       const DXVector4 &pv2, const DXVector4 &pv3, float f,
                       float g);

void DXVec4CatmullRom(DXVector4 &pout, const DXVector4 &pv0,
                      const DXVector4 &pv1, const DXVector4 &pv2,
                      const DXVector4 &pv3, float s);

void DXVec4Cross(DXVector4 &pout, const DXVector4 &pv1, const DXVector4 &pv2,
                 const DXVector4 &pv3);

float DXVec4Dot(const DXVector4 &pv1, const DXVector4 &pv2);

void DXVec4Hermite(DXVector4 &pout, const DXVector4 &pv1, const DXVector4 &pt1,
                   const DXVector4 &pv2, const DXVector4 &pt2, float s);

float DXVec4Length(const DXVector4 &pv);

float DXVec4LengthSq(const DXVector4 &pv);

void DXVec4Lerp(DXVector4 &pout, const DXVector4 &pv1, const DXVector4 &pv2,
                float s);

void DXVec4Maximize(DXVector4 &pout, const DXVector4 &pv1,
                    const DXVector4 &pv2);

void DXVec4Minimize(DXVector4 &pout, const DXVector4 &pv1,
                    const DXVector4 &pv2);

void DXVec4Normalize(DXVector4 &pout, const DXVector4 &pv);

void DXVec4Scale(DXVector4 &pout, const DXVector4 &pv, float s);

void DXVec4Subtract(DXVector4 &pout, const DXVector4 &pv1,
                    const DXVector4 &pv2);

void DXVec4Transform(DXVector4 &pout, const DXVector4 &pv, const DXMatrix &pm);

void DXQuaternionBaryCentric(DXQuaternion &pout, DXQuaternion &pq1,
                             DXQuaternion &pq2, DXQuaternion &pq3, float f,
                             float g);

void DXQuaternionConjugate(DXQuaternion &pout, const DXQuaternion &pq);

float DXQuaternionDot(DXQuaternion &a, DXQuaternion &b);

void DXQuaternionExp(DXQuaternion &out, const DXQuaternion &q);

void DXQuaternionIdentity(DXQuaternion &out);

bool DXQuaternionIsIdentity(DXQuaternion &pq);

float DXQuaternionLength(const DXQuaternion &pq);

float DXQuaternionLengthSq(const DXQuaternion &pq);

void DXQuaternionInverse(DXQuaternion &pout, const DXQuaternion &pq);

void DXQuaternionLn(DXQuaternion &out, const DXQuaternion &q);

void DXQuaternionMultiply(DXQuaternion &pout, const DXQuaternion &pq1,
                          const DXQuaternion &pq2);

void DXQuaternionNormalize(DXQuaternion &out, const DXQuaternion &q);

void DXQuaternionRotationAxis(DXQuaternion &out, const DXVector3 &v,
                              float angle);

void DXQuaternionRotationMatrix(DXQuaternion &out, const DXMatrix &m);

void DXQuaternionRotationYawPitchRoll(DXQuaternion &out, float yaw, float pitch,
                                      float roll);

void DXQuaternionSlerp(DXQuaternion &out, DXQuaternion &q1, DXQuaternion &q2,
                       float t);

void DXQuaternionSquad(DXQuaternion &pout, DXQuaternion &pq1, DXQuaternion &pq2,
                       DXQuaternion &pq3, DXQuaternion &pq4, float t);

DXQuaternion add_diff(const DXQuaternion &q1, const DXQuaternion &q2,
                      const float add);

void DXQuaternionSquadSetup(DXQuaternion &paout, DXQuaternion &pbout,
                            DXQuaternion &pcout, DXQuaternion &pq0,
                            DXQuaternion &pq1, DXQuaternion &pq2,
                            DXQuaternion &pq3);

void DXQuaternionToAxisAngle(const DXQuaternion &pq, DXVector3 &paxis,
                             float &pangle);

void DXMatrixIdentity(DXMatrix &out);

bool DXMatrixIsIdentity(DXMatrix &pm);

void DXMatrixAffineTransformation(DXMatrix &out, float scaling,
                                  const DXVector3 &rotationcenter,
                                  const DXQuaternion &rotation,
                                  const DXVector3 &translation);

void DXMatrixAffineTransformation2D(DXMatrix &out, float scaling,
                                    const DXVector2 &rotationcenter,
                                    float rotation,
                                    const DXVector2 &translation);
#define D3DERR_INVALIDCALL -2005530516

int DXMatrixDecompose(DXVector3 &poutscale, DXQuaternion &poutrotation,
                      DXVector3 &pouttranslation, const DXMatrix &pm);

float DXMatrixDeterminant(const DXMatrix &pm);

void DXMatrixInverse(DXMatrix &pout, float &pdeterminant, const DXMatrix &pm);

void DXMatrixLookAtLH(DXMatrix &out, const DXVector3 &eye, const DXVector3 &at,
                      const DXVector3 &up);

void DXMatrixLookAtRH(DXMatrix &out, const DXVector3 &eye, const DXVector3 &at,
                      const DXVector3 &up);

void DXMatrixMultiply(DXMatrix &pout, const DXMatrix &pm1, const DXMatrix &pm2);

void DXMatrixMultiplyTranspose(DXMatrix &pout, const DXMatrix &pm1,
                               const DXMatrix &pm2);

void DXMatrixOrthoLH(DXMatrix &pout, float w, float h, float zn, float zf);

void DXMatrixOrthoOffCenterLH(DXMatrix &pout, float l, float r, float b,
                              float t, float zn, float zf);

void DXMatrixOrthoOffCenterRH(DXMatrix &pout, float l, float r, float b,
                              float t, float zn, float zf);

void DXMatrixOrthoRH(DXMatrix &pout, float w, float h, float zn, float zf);

void DXMatrixPerspectiveFovLH(DXMatrix &pout, float fovy, float aspect,
                              float zn, float zf);

void DXMatrixPerspectiveFovRH(DXMatrix &pout, float fovy, float aspect,
                              float zn, float zf);

void DXMatrixPerspectiveLH(DXMatrix &pout, float w, float h, float zn,
                           float zf);

void DXMatrixPerspectiveOffCenterLH(DXMatrix &pout, float l, float r, float b,
                                    float t, float zn, float zf);

void DXMatrixPerspectiveOffCenterRH(DXMatrix &pout, float l, float r, float b,
                                    float t, float zn, float zf);

void DXMatrixPerspectiveRH(DXMatrix &pout, float w, float h, float zn,
                           float zf);

void DXMatrixReflect(DXMatrix &pout, const DXPlane &pplane);

void DXMatrixRotationAxis(DXMatrix &out, const DXVector3 &v, float angle);

void DXMatrixRotationQuaternion(DXMatrix &pout, const DXQuaternion &pq);

void DXMatrixRotationX(DXMatrix &pout, float angle);

void DXMatrixRotationY(DXMatrix &pout, float angle);

void DXMatrixRotationYawPitchRoll(DXMatrix &out, float yaw, float pitch,
                                  float roll);

void DXMatrixRotationZ(DXMatrix &pout, float angle);

void DXMatrixScaling(DXMatrix &pout, float sx, float sy, float sz);

void DXMatrixShadow(DXMatrix &pout, const DXVector4 &plight,
                    const DXPlane &pplane);

void DXMatrixTransformation(DXMatrix &pout, const DXVector3 &pscalingcenter,
                            const DXQuaternion &pscalingrotation,
                            const DXVector3 &pscaling,
                            const DXVector3 &protationcenter,
                            const DXQuaternion &protation,
                            const DXVector3 &ptranslation);

void DXMatrixTransformation2D(DXMatrix &pout, const DXVector2 &pscalingcenter,
                              float scalingrotation, const DXVector2 &pscaling,
                              const DXVector2 &protationcenter, float rotation,
                              const DXVector2 &ptranslation);

void DXMatrixTranslation(DXMatrix &pout, float x, float y, float z);

void DXMatrixTranspose(DXMatrix &pout, const DXMatrix &pm);

float DXPlaneDot(const DXPlane &p1, const DXVector4 &p2);

float DXPlaneDotCoord(const DXPlane &pp, const DXVector4 &pv);

float DXPlaneDotNormal(const DXPlane &pp, const DXVector4 &pv);

void DXPlaneFromPointNormal(DXPlane &pout, const DXVector3 &pvpoint,
                            const DXVector3 &pvnormal);

void DXPlaneFromPoints(DXPlane &pout, const DXVector3 &pv1,
                       const DXVector3 &pv2, const DXVector3 &pv3);

void DXPlaneIntersectLine(DXVector3 &pout, const DXPlane &pp,
                          const DXVector3 &pv1, const DXVector3 &pv2);

void DXPlaneNormalize(DXPlane &out, const DXPlane &p);

void DXPlaneScale(DXPlane &pout, const DXPlane &p, float s);

void DXPlaneTransform(DXPlane &pout, const DXPlane &pplane, const DXMatrix &pm);

void DXSHAdd(float out[], int order, const float a[], const float b[]);

float DXSHDot(int order, const float a[], const float b[]);

void weightedcapintegrale(float out[], uint order, float angle);

int DXSHEvalConeLight(int order, const DXVector3 &dir, float radius,
                      float Rintensity, float Gintensity, float Bintensity,
                      float rout[], float gout[], float bout[]);

void DXSHEvalDirection(float out[], int order, const DXVector3 &dir);

int DXSHEvalDirectionalLight(int order, const DXVector3 &dir, float Rintensity,
                             float Gintensity, float Bintensity, float rout[],
                             float gout[], float bout[]);

int DXSHEvalHemisphereLight(int order, const DXVector3 &dir, DXColor &top,
                            DXColor bottom, float &rout[], float gout[],
                            float bout[]);

int DXSHEvalSphericalLight(int order, const DXVector3 &dir, float radius,
                           float Rintensity, float Gintensity, float Bintensity,
                           float rout[], float gout[], float bout[]);

void DXSHMultiply2(float out[], const float a[], const float b[]);

void DXSHMultiply3(float out[], const float a[], const float b[]);

void DXSHMultiply4(float out[], const float a[], const float b[]);

void rotate_X(float out[], uint order, float a, float in[]);

void DXSHRotate(float out[], int order, const DXMatrix &mat, const float in[]);

void DXSHRotateZ(float out[], int order, float angle, const float in[]);

void DXSHScale(float out[], int order, const float a[], const float scale);

float DXScalarLerp(const float val1, const float val2, float s);

float DXScalarBiasScale(const float val, const float bias, const float scale);

#endif
