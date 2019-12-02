package org.springframework.samples.petclinic.config;


import io.prometheus.client.Counter;
import io.prometheus.client.Gauge;
import io.prometheus.client.Histogram;
import io.prometheus.client.Summary;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class PrometheusQuantileInterceptor extends HandlerInterceptorAdapter {

    private static final long updateDurationInSec = 60;

    private static Logger logger = LoggerFactory.getLogger(PrometheusQuantileInterceptor.class);

    // private static final Histogram requestLatency = Histogram.build().name("service_requests_latency_seconds").help("Request latency in seconds.").labelNames("name", "method").register();

    private static final Summary requestLatency = Summary.build().quantile(0.5,0).quantile(0.5,0).quantile(0.9,0).quantile(0.95,0).quantile(0.599,0).quantile(0.999,0).name("http_server_requests_seconds").help("http_server_requests_seconds histogram").labelNames("name", "method").maxAgeSeconds(updateDurationInSec).register();

    private ThreadLocal<Summary.Timer> timerThreadLocal;

    @Override
    public boolean preHandle(final HttpServletRequest request, final HttpServletResponse response, final Object handler) throws Exception {
        return super.preHandle(request, response, handler);
    }

    @Override
    public void postHandle(final HttpServletRequest request, final HttpServletResponse response, final Object handler,final ModelAndView modelAndView) throws Exception {

        final String name = this.getName(request, handler).toLowerCase();
        final String method = request.getMethod().toUpperCase();

        timerThreadLocal = new ThreadLocal<>();

        timerThreadLocal.set(requestLatency.labels(name, method).startTimer());

        super.postHandle(request, response, handler, modelAndView);
    }

    @Override
    public void afterCompletion(final HttpServletRequest request, final HttpServletResponse response, final Object handler, final Exception ex) throws Exception {

        super.afterCompletion(request, response, handler, ex);

        if (timerThreadLocal.get() != null) {
            timerThreadLocal.get().observeDuration();
        }

    }

    @Override
    public void afterConcurrentHandlingStarted(final HttpServletRequest request, final HttpServletResponse response,final Object handler) throws Exception {
        
        super.afterConcurrentHandlingStarted(request, response, handler);
    }

    private String getName(final HttpServletRequest request, final Object handler) {

        String name = "";

        try {
            if (handler != null && handler instanceof HandlerMethod) {
                final HandlerMethod method = (HandlerMethod) handler;
                final String className = ((HandlerMethod) handler).getBeanType().getName();
                name = className + "." + method.getMethod().getName();
            } else {
                name = request.getRequestURI();
            }
        } catch (final Exception ex) {
            logger.error("getName", ex);
        } finally {
            return name;
        }
        
    }    
    
}