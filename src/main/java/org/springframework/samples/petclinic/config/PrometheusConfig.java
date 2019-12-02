package org.springframework.samples.petclinic.config;

import javax.annotation.PostConstruct;
import io.prometheus.client.hotspot.DefaultExports;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class PrometheusConfig {

    private static Logger logger = LoggerFactory.getLogger(PrometheusConfig.class);
    
    @PostConstruct
    public void initialize() {
        logger.info("Prometheus init...");
        DefaultExports.initialize();
        logger.info("Prometheus has been initialized...");
    }

}