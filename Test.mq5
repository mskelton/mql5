#include <Arrays/Array.mqh>
#include <Arrays/ArrayChar.mqh>
#include <Arrays/ArrayDouble.mqh>
#include <Arrays/ArrayFloat.mqh>
#include <Arrays/ArrayInt.mqh>
#include <Arrays/ArrayLong.mqh>
#include <Arrays/ArrayObj.mqh>
#include <Arrays/ArrayShort.mqh>
#include <Arrays/ArrayString.mqh>
#include <Arrays/List.mqh>
#include <Arrays/Tree.mqh>
#include <Arrays/TreeNode.mqh>
// #include <Canvas/Canvas.mqh>
// #include <Canvas/Canvas3D.mqh>
// #include <Canvas/Charts/ChartCanvas.mqh>
// #include <Canvas/Charts/HistogramChart.mqh>
// #include <Canvas/Charts/LineChart.mqh>
// #include <Canvas/Charts/PieChart.mqh>
// #include <Canvas/DX/DXBox.mqh>
// #include <Canvas/DX/DXBuffers.mqh>
// #include <Canvas/DX/DXData.mqh>
// #include <Canvas/DX/DXDispatcher.mqh>
// #include <Canvas/DX/DXHandle.mqh>
// #include <Canvas/DX/DXInput.mqh>
// #include <Canvas/DX/DXMath.mqh>
// #include <Canvas/DX/DXMesh.mqh>
// #include <Canvas/DX/DXObject.mqh>
// #include <Canvas/DX/DXObjectBase.mqh>
// #include <Canvas/DX/DXShader.mqh>
// #include <Canvas/DX/DXSurface.mqh>
// #include <Canvas/DX/DXTexture.mqh>
// #include <Canvas/DX/DXUtils.mqh>
// #include <Canvas/FlameCanvas.mqh>
// #include <ChartObjects/ChartObject.mqh>
// #include <ChartObjects/ChartObjectPanel.mqh>
// #include <ChartObjects/ChartObjectSubChart.mqh>
// #include <ChartObjects/ChartObjectsArrows.mqh>
// #include <ChartObjects/ChartObjectsBmpControls.mqh>
// #include <ChartObjects/ChartObjectsChannels.mqh>
// #include <ChartObjects/ChartObjectsElliott.mqh>
// #include <ChartObjects/ChartObjectsFibo.mqh>
// #include <ChartObjects/ChartObjectsGann.mqh>
// #include <ChartObjects/ChartObjectsLines.mqh>
// #include <ChartObjects/ChartObjectsShapes.mqh>
// #include <ChartObjects/ChartObjectsTxtControls.mqh>
// #include <Charts/Chart.mqh>
// #include <Controls/BmpButton.mqh>
// #include <Controls/Button.mqh>
// #include <Controls/CheckBox.mqh>
// #include <Controls/CheckGroup.mqh>
// #include <Controls/ComboBox.mqh>
// #include <Controls/DateDropList.mqh>
// #include <Controls/DatePicker.mqh>
// #include <Controls/Defines.mqh>
// #include <Controls/Dialog.mqh>
// #include <Controls/Edit.mqh>
// #include <Controls/Label.mqh>
// #include <Controls/ListView.mqh>
// #include <Controls/Panel.mqh>
// #include <Controls/Picture.mqh>
// #include <Controls/RadioButton.mqh>
// #include <Controls/RadioGroup.mqh>
// #include <Controls/Rect.mqh>
// #include <Controls/Scrolls.mqh>
// #include <Controls/SpinEdit.mqh>
// #include <Controls/Wnd.mqh>
// #include <Controls/WndClient.mqh>
// #include <Controls/WndContainer.mqh>
// #include <Controls/WndObj.mqh>
// #include <Expert/Expert.mqh>
// #include <Expert/ExpertBase.mqh>
// #include <Expert/ExpertMoney.mqh>
// #include <Expert/ExpertSignal.mqh>
// #include <Expert/ExpertTrade.mqh>
// #include <Expert/ExpertTrailing.mqh>
// #include <Expert/Money/MoneyFixedLot.mqh>
// #include <Expert/Money/MoneyFixedMargin.mqh>
// #include <Expert/Money/MoneyFixedRisk.mqh>
// #include <Expert/Money/MoneyNone.mqh>
// #include <Expert/Money/MoneySizeOptimized.mqh>
// #include <Expert/Signal/SignalAC.mqh>
// #include <Expert/Signal/SignalAMA.mqh>
// #include <Expert/Signal/SignalAO.mqh>
// #include <Expert/Signal/SignalBearsPower.mqh>
// #include <Expert/Signal/SignalBullsPower.mqh>
// #include <Expert/Signal/SignalCCI.mqh>
// #include <Expert/Signal/SignalDEMA.mqh>
// #include <Expert/Signal/SignalDeMarker.mqh>
// #include <Expert/Signal/SignalEnvelopes.mqh>
// #include <Expert/Signal/SignalFrAMA.mqh>
// #include <Expert/Signal/SignalITF.mqh>
// #include <Expert/Signal/SignalMA.mqh>
// #include <Expert/Signal/SignalMACD.mqh>
// #include <Expert/Signal/SignalRSI.mqh>
// #include <Expert/Signal/SignalRVI.mqh>
// #include <Expert/Signal/SignalSAR.mqh>
// #include <Expert/Signal/SignalStoch.mqh>
// #include <Expert/Signal/SignalTEMA.mqh>
// #include <Expert/Signal/SignalTRIX.mqh>
// #include <Expert/Signal/SignalWPR.mqh>
// #include <Expert/Trailing/TrailingFixedPips.mqh>
// #include <Expert/Trailing/TrailingMA.mqh>
// #include <Expert/Trailing/TrailingNone.mqh>
// #include <Expert/Trailing/TrailingParabolicSAR.mqh>
#include <Files/File.mqh>
#include <Files/FileBMP.mqh>
#include <Files/FileBin.mqh>
#include <Files/FilePipe.mqh>
#include <Files/FileTxt.mqh>
// #include <Generic/ArrayList.mqh>
// #include <Generic/HashMap.mqh>
// #include <Generic/HashSet.mqh>
// #include <Generic/Interfaces/ICollection.mqh>
// #include <Generic/Interfaces/IComparable.mqh>
// #include <Generic/Interfaces/IComparer.mqh>
// #include <Generic/Interfaces/IEqualityComparable.mqh>
// #include <Generic/Interfaces/IEqualityComparer.mqh>
// #include <Generic/Interfaces/IList.mqh>
// #include <Generic/Interfaces/IMap.mqh>
// #include <Generic/Interfaces/ISet.mqh>
// #include <Generic/Internal/ArrayFunction.mqh>
// #include <Generic/Internal/CompareFunction.mqh>
// #include <Generic/Internal/DefaultComparer.mqh>
// #include <Generic/Internal/DefaultEqualityComparer.mqh>
// #include <Generic/Internal/EqualFunction.mqh>
// #include <Generic/Internal/HashFunction.mqh>
// #include <Generic/Internal/Introsort.mqh>
// #include <Generic/Internal/PrimeGenerator.mqh>
// #include <Generic/LinkedList.mqh>
// #include <Generic/Queue.mqh>
// #include <Generic/RedBlackTree.mqh>
// #include <Generic/SortedMap.mqh>
// #include <Generic/SortedSet.mqh>
// #include <Generic/Stack.mqh>
// #include <Graphics/Axis.mqh>
// #include <Graphics/ColorGenerator.mqh>
// #include <Graphics/Curve.mqh>
// #include <Graphics/Graphic.mqh>
// #include <Indicators/BillWilliams.mqh>
// #include <Indicators/Custom.mqh>
// #include <Indicators/Indicator.mqh>
// #include <Indicators/Indicators.mqh>
// #include <Indicators/Oscilators.mqh>
// #include <Indicators/Series.mqh>
// #include <Indicators/TimeSeries.mqh>
// #include <Indicators/Trend.mqh>
// #include <Indicators/Volumes.mqh>
// #include <Math/Alglib/alglib.mqh>
// #include <Math/Alglib/alglibinternal.mqh>
// #include <Math/Alglib/alglibmisc.mqh>
// #include <Math/Alglib/ap.mqh>
// #include <Math/Alglib/arrayresize.mqh>
// #include <Math/Alglib/bitconvert.mqh>
// #include <Math/Alglib/complex.mqh>
// #include <Math/Alglib/dataanalysis.mqh>
// #include <Math/Alglib/delegatefunctions.mqh>
// #include <Math/Alglib/diffequations.mqh>
// #include <Math/Alglib/fasttransforms.mqh>
// #include <Math/Alglib/integration.mqh>
// #include <Math/Alglib/interpolation.mqh>
// #include <Math/Alglib/linalg.mqh>
// #include <Math/Alglib/matrix.mqh>
// #include <Math/Alglib/optimization.mqh>
// #include <Math/Alglib/solvers.mqh>
// #include <Math/Alglib/specialfunctions.mqh>
// #include <Math/Alglib/statistics.mqh>
// #include <Math/Fuzzy/dictionary.mqh>
// #include <Math/Fuzzy/fuzzyrule.mqh>
// #include <Math/Fuzzy/fuzzyterm.mqh>
// #include <Math/Fuzzy/fuzzyvariable.mqh>
// #include <Math/Fuzzy/genericfuzzysystem.mqh>
// #include <Math/Fuzzy/helper.mqh>
// #include <Math/Fuzzy/inferencemethod.mqh>
// #include <Math/Fuzzy/mamdanifuzzysystem.mqh>
// #include <Math/Fuzzy/membershipfunction.mqh>
// #include <Math/Fuzzy/ruleparser.mqh>
// #include <Math/Fuzzy/sugenofuzzysystem.mqh>
// #include <Math/Fuzzy/sugenovariable.mqh>
// #include <Math/Stat/Beta.mqh>
// #include <Math/Stat/Binomial.mqh>
// #include <Math/Stat/Cauchy.mqh>
// #include <Math/Stat/ChiSquare.mqh>
// #include <Math/Stat/Exponential.mqh>
// #include <Math/Stat/F.mqh>
// #include <Math/Stat/Gamma.mqh>
// #include <Math/Stat/Geometric.mqh>
// #include <Math/Stat/Hypergeometric.mqh>
// #include <Math/Stat/Logistic.mqh>
// #include <Math/Stat/Lognormal.mqh>
// #include <Math/Stat/Math.mqh>
// #include <Math/Stat/NegativeBinomial.mqh>
// #include <Math/Stat/NoncentralBeta.mqh>
// #include <Math/Stat/NoncentralChiSquare.mqh>
// #include <Math/Stat/NoncentralF.mqh>
// #include <Math/Stat/NoncentralT.mqh>
// #include <Math/Stat/Normal.mqh>
// #include <Math/Stat/Poisson.mqh>
// #include <Math/Stat/Stat.mqh>
// #include <Math/Stat/T.mqh>
// #include <Math/Stat/Uniform.mqh>
// #include <Math/Stat/Weibull.mqh>
// #include <MovingAverages.mqh>
#include <Object.mqh>
#include <OpenCL/OpenCL.mqh>
#include <StdLibErr.mqh>
#include <Strings/String.mqh>
#include <Tools/DateTime.mqh>
#include <Trade/AccountInfo.mqh>
#include <Trade/DealInfo.mqh>
#include <Trade/HistoryOrderInfo.mqh>
#include <Trade/OrderInfo.mqh>
#include <Trade/PositionInfo.mqh>
#include <Trade/SymbolInfo.mqh>
#include <Trade/TerminalInfo.mqh>
#include <Trade/Trade.mqh>
// #include <VirtualKeys.mqh>
// #include <WinAPI/errhandlingapi.mqh>
// #include <WinAPI/fileapi.mqh>
// #include <WinAPI/handleapi.mqh>
// #include <WinAPI/libloaderapi.mqh>
// #include <WinAPI/memoryapi.mqh>
// #include <WinAPI/processenv.mqh>
// #include <WinAPI/processthreadsapi.mqh>
// #include <WinAPI/securitybaseapi.mqh>
// #include <WinAPI/sysinfoapi.mqh>
// #include <WinAPI/winapi.mqh>
// #include <WinAPI/winbase.mqh>
// #include <WinAPI/windef.mqh>
// #include <WinAPI/wingdi.mqh>
// #include <WinAPI/winnt.mqh>
// #include <WinAPI/winreg.mqh>
// #include <WinAPI/winuser.mqh>