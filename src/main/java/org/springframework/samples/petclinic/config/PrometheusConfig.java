package org.springframework.samples.petclinic.config;

import javax.annotation.PostConstruct;
import io.prometheus.client.hotspot.DefaultExports;

public class PrometheusConfig {
    
    @PostConstruct
    public void initialize() {
        DefaultExports.initialize();
    }

}