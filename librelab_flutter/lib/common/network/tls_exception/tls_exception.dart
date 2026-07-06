/// For doc comments, refer to `tls_exception_web.dart`.
library;

export 'tls_exception_io.dart'
    if (dart.library.js_interop) 'tls_exception_web.dart';
