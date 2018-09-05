package js.axios;

import js.Promise;
import js.Error;
import js.html.URLSearchParams;
import js.html.ArrayBuffer;
import js.html.ArrayBufferView;
import js.html.FormData;
import js.html.Blob;
import js.html.ProgressEvent;
#if nodejs
import js.node.Buffer;
import js.node.Stream;
#end
import haxe.extern.Rest;
import externtype.Mixed2;
import externtype.Mixed7;
import externtype.ValueOrArray;
import externtype.ReadOnlyArray;

@:jsRequire("axios")
extern class Axios {
    @:selfCall
    @:overload(function(config: AxiosRequestConfig): Promise<AxiosResponse> {})
    static function call(url: String, ?config: AxiosRequestConfig): Promise<AxiosResponse>;

    static function create(?config: AxiosRequestConfig): Axios;
    static function isCancel(value: Dynamic): Bool;
    static function all(values: Array<Mixed2<Dynamic, Promise<Dynamic>>>): Promise<ReadOnlyArray<Dynamic>>;
    static function spread<R>(callback: Rest<Dynamic> -> R): ReadOnlyArray<Dynamic> -> R;

    static var interceptors(default, null): {
        var request(default, default): AxiosInterceptorManager<AxiosRequestConfig>;
        var response(default, default): AxiosInterceptorManager<AxiosResponse>;
    };
    static function request(config: AxiosRequestConfig): Promise<AxiosResponse>;
    static function get(url: String, ?config: AxiosRequestConfig): Promise<AxiosResponse>;
    static function delete(url: String, ?config: AxiosRequestConfig): Promise<AxiosResponse>;
    static function head(url: String, ?config: AxiosRequestConfig): Promise<AxiosResponse>;
    static function post(url: String, ?data: Dynamic, ?config: AxiosRequestConfig): Promise<AxiosResponse>;
    static function put(url: String, ?data: Dynamic, ?config: AxiosRequestConfig): Promise<AxiosResponse>;
    static function patch(url: String, ?data: Dynamic, ?config: AxiosRequestConfig): Promise<AxiosResponse>;

    var interceptors(default, null): {
        var request(default, default): AxiosInterceptorManager<AxiosRequestConfig>;
        var response(default, default): AxiosInterceptorManager<AxiosResponse>;
    };
    function request(config: AxiosRequestConfig): Promise<AxiosResponse>;
    function get(url: String, ?config: AxiosRequestConfig): Promise<AxiosResponse>;
    function delete(url: String, ?config: AxiosRequestConfig): Promise<AxiosResponse>;
    function head(url: String, ?config: AxiosRequestConfig): Promise<AxiosResponse>;
    function post(url: String, ?data: Dynamic, ?config: AxiosRequestConfig): Promise<AxiosResponse>;
    function put(url: String, ?data: Dynamic, ?config: AxiosRequestConfig): Promise<AxiosResponse>;
    function patch(url: String, ?data: Dynamic, ?config: AxiosRequestConfig): Promise<AxiosResponse>;
}

/**
 * A `Cancel` is an object that is thrown when an operation is canceled.
 */
@:jsRequire("axios", "Cancel")
extern class Cancel {
    var message(default, null): String;
    function new(?message: String);
}

/**
 * A `CancelToken` is an object that can be used to request cancellation of an operation.
 */
@:jsRequire("axios", "CancelToken")
extern class CancelToken {
    var promise(default, null): Promise<Cancel>;
    var reason(default, null): Null<Cancel>;

    function new(executor: CancellFunc -> Void);

    /**
     * Throws a `Cancel` if cancellation has been requested.
     */
    function throwIfRequested(): Void;
    /**
     * Returns an object that contains a new `CancelToken` and a function that, when called,
     * cancels the `CancelToken`.
     */
     static function source(): CancelTokenSource;
}

typedef CancelTokenSource = {
    var token(default, null): CancelToken;
    var cancel(default, null): CancellFunc;
}

typedef CancellFunc = ?String -> Void;

typedef AxiosRequestConfig = {
    /**
     * `url` is the server URL that will be used for the request
     */
    @:optional var url: String;
    /**
     * `method` is the request method to be used when making the request
     */
    @:optional var method: AxiosMethod;
    /**
     * `baseURL` will be prepended to `url` unless `url` is absolute.
     * It can be convenient to set `baseURL` for an instance of axios to pass relative URLs
     * to methods of that instance.
     */
    @:optional var baseURL: String;
    /**
     * `transformRequest` allows changes to the request data before it is sent to the server
     * This is only applicable for request methods 'PUT', 'POST', and 'PATCH'
     * The last function in the array must return a string or an instance of Buffer, ArrayBuffer,
     * FormData or Stream
     * You may modify the headers object.
     */
    @:optional var transformRequest: ValueOrArray<AxiosTransformer>;
    /**
     * `transformResponse` allows changes to the response data to be made before
     * it is passed to then/catch
     */
    @:optional var transformResponse: ValueOrArray<AxiosTransformer>;
    /**
     * `headers` are custom headers to be sent
     */
    @:optional var headers: Dynamic<String>;
    /**
     * `params` are the URL parameters to be sent with the request
     * Must be a plain object or a URLSearchParams object
     */
    @:optional var params: Mixed2<Dynamic<Dynamic>, URLSearchParams>;
    /**
     * `paramsSerializer` is an optional function in charge of serializing `params`
     * (e.g. https://www.npmjs.com/package/qs, http://api.jquery.com/jquery.param/)
     */
    @:optional var paramsSerializer: AxiosParamsSerializer;
    /*
     * `data` is the data to be sent as the request body
     * Only applicable for request methods 'PUT', 'POST', and 'PATCH'
     * When no `transformRequest` is set, must be of one of the following types:
     * - string, plain object, ArrayBuffer, ArrayBufferView, URLSearchParams
     * - Browser only: FormData, File, Blob
     * - Node only: Stream, Buffer
     */
    @:optional var data:
        #if nodejs Mixed7<String, {}, ArrayBuffer, ArrayBufferView, URLSearchParams, Stream<Dynamic>, Buffer>
        #else Mixed7<String, {}, ArrayBuffer, ArrayBufferView, URLSearchParams, FormData, Blob>
        #end;
    /**
     * `timeout` specifies the number of milliseconds before the request times out.
     * If the request takes longer than `timeout`, the request will be aborted.
     */
    @:optional var timeout: Int;
    /**
     * `withCredentials` indicates whether or not cross-site Access-Control requests
     * should be made using credentials
     */
    @:optional var withCredentials: Bool;
    /**
     * `adapter` allows custom handling of requests which makes testing easier.
     *  Return a promise and supply a valid response (see lib/adapters/README.md).
     */
    @:optional var adapter: AxiosAdapter;
    /**
     * `auth` indicates that HTTP Basic auth should be used, and supplies credentials.
     * This will set an `Authorization` header, overwriting any existing
     * `Authorization` custom headers you have set using `headers`.
     */
    @:optional var auth: AxiosBasicCredentials;
    /**
     * `responseType` indicates the type of data that the server will respond with
     * options are 'arraybuffer', 'blob', 'document', 'json', 'text', 'stream'
     */
    @:optional var responseType: AxiosResponseType;
    /**
     * `responseEncoding` indicates encoding to use for decoding responses
     * Note: Ignored for `responseType` of 'stream' or client-side requests
     */
    @:optional var responseEncoding: String;
    /**
     * `xsrfCookieName` is the name of the cookie to use as a value for xsrf token
     */
    @:optional var xsrfCookieName: String;
    /**
     * `xsrfHeaderName` is the name of the http header that carries the xsrf token value
     */
    @:optional var xsrfHeaderName: String;
    #if !node
    /**
     * `onUploadProgress` allows handling of progress events for uploads
     */
    @:optional var onUploadProgress: AxiosProgressEventHandler;
    /**
     * `onDownloadProgress` allows handling of progress events for downloads
     */
    @:optional var onDownloadProgress: AxiosProgressEventHandler;
    #end
    /**
     * `maxContentLength` defines the max size of the http response content in bytes allowed
     */
    @:optional var maxContentLength: Int;
    /**
     * `validateStatus` defines whether to resolve or reject the promise for a given
     * HTTP response status code. If `validateStatus` returns `true` (or is set to `null`
     * or `undefined`), the promise will be resolved; otherwise, the promise will be
     * rejected.
     */
    @:optional var validateStatus: AxiosStatusValidator;
    /**
     * `maxRedirects` defines the maximum number of redirects to follow in node.js.
     * If set to 0, no redirects will be followed.
     */
    @:optional var maxRedirects: Int;
    /**
     * `socketPath` defines a UNIX Socket to be used in node.js.
     * e.g. '/var/run/docker.sock' to send requests to the docker daemon.
     * Only either `socketPath` or `proxy` can be specified.
     * f both are specified, `socketPath` is used.
     */
    @:optional var socketPath: String;
    #if nodejs
    /**
     * `httpAgent` and `httpsAgent` define a custom agent to be used when performing http
     * and https requests, respectively, in node.js. This allows options to be added like
     * `keepAlive` that are not enabled by default.
     */
    @:optional var httpAgent: js.node.http.Agent;
    /**
     * @see httpAgent
     */
    @:optional var httpsAgent: js.node.https.Agent;
    #end
    /**
     * 'proxy' defines the hostname and port of the proxy server
     * Use `false` to disable proxies, ignoring environment variables.
     * `auth` indicates that HTTP Basic auth should be used to connect to the proxy, and
     * supplies credentials.
     * This will set an `Proxy-Authorization` header, overwriting any existing
     * `Proxy-Authorization` custom headers you have set using `headers`.
     */
    @:optional var proxy: Mixed2<AxiosProxyConfig, Bool>;
    /**
     * `cancelToken` specifies a cancel token that can be used to cancel the request
     * (see Cancellation section below for details)
     */
    @:optional var cancelToken: CancelToken;
}

@:enum abstract AxiosMethod(String) from String to String {
    var Get = "get";
    var Delete = "delete";
    var Head = "head";
    var Options = "options";
    var Post = "post";
    var Put = "put";
    var Patch = "patch";
}

@:enum abstract AxiosResponseType(String) from String to String {
    var ArrayBuffer = "arraybuffer";
    var Blob ="blob";
    var Document = "document";
    var Json = "json";
    var Text = "text";
    var Stream = "stream";
}

typedef AxiosTransformer = Dynamic -> ?Dynamic -> Dynamic;
typedef AxiosAdapter = AxiosRequestConfig -> Promise<AxiosResponse>;
typedef AxiosParamsSerializer = Mixed2<Dynamic<Dynamic>, URLSearchParams> -> String;
typedef AxiosProgressEventHandler = ProgressEvent -> Void;
typedef AxiosStatusValidator = Int -> Bool;

typedef AxiosBasicCredentials = {
    var username: String;
    var password: String;
}

typedef AxiosProxyConfig = {
    var host: String;
    var port: Int;
    @:optional var auth: {
        var username: String;
        var password: String;
    }
}

typedef AxiosInterceptorManager<T> = {
    function use(
        ?onFulfilled: T -> Mixed2<T, Promise<T>>,
        ?onRejected: Dynamic -> Dynamic
    ): Int;
    function eject(id: Int): Void;
}

typedef AxiosResponse = {
    var data(default, null): Dynamic;
    var status(default, null): Int;
    var statusText(default, null): String;
    var headers(default, null): Dynamic;
    var config(default, null): AxiosRequestConfig;
    var request(default, null): Null<Dynamic>;
}

abstract AxiosError(Error) from Error to Error {
    public var config(get, never): AxiosRequestConfig;
    public var code(get, never): Null<String>;
    public var request(get, never): Null<Dynamic>;
    public var response(get, never): Null<AxiosResponse>;
    public var isAxiosError(get, never): Bool;

    inline function get_config() {
        return untyped this.config;
    }

    inline function get_code() {
        return untyped this.code;
    }

    inline function get_request() {
        return untyped this.request;
    }

    inline function get_response() {
        return untyped this.response;
    }

    inline function get_isAxiosError() {
        return untyped this.isAxiosError;
    }
}
