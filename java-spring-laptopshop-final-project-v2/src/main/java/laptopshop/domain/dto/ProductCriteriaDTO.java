package laptopshop.domain.dto;

import java.util.List;
import java.util.Optional;

public class ProductCriteriaDTO {
    private Optional<String> page;
    private Optional<String> name;
    private Optional<List<String>> factory;
    private Optional<List<String>> target;
    private Optional<List<String>> price;
    private Optional<Double> minPrice;
    private Optional<Double> maxPrice;
    private Optional<String> sort;
    private Optional<List<String>> cpu;
    private Optional<List<String>> ram;
    private Optional<List<String>> storage;
    private Optional<List<String>> screen;
    private Optional<List<String>> gpu;
    private Optional<List<String>> hz;
    private Optional<List<String>> security;
    private Optional<List<String>> color;

    public Optional<List<String>> getColor() {
        return color;
    }

    public void setColor(Optional<List<String>> color) {
        this.color = color;
    }

    public Optional<List<String>> getStorage() {
        return storage;
    }

    public void setStorage(Optional<List<String>> storage) {
        this.storage = storage;
    }

    public Optional<List<String>> getScreen() {
        return screen;
    }

    public void setScreen(Optional<List<String>> screen) {
        this.screen = screen;
    }

    public Optional<List<String>> getGpu() {
        return gpu;
    }

    public void setGpu(Optional<List<String>> gpu) {
        this.gpu = gpu;
    }

    public Optional<List<String>> getHz() {
        return hz;
    }

    public void setHz(Optional<List<String>> hz) {
        this.hz = hz;
    }

    public Optional<List<String>> getSecurity() {
        return security;
    }

    public void setSecurity(Optional<List<String>> security) {
        this.security = security;
    }

    public Optional<Double> getMinPrice() {
        return minPrice;
    }

    public void setMinPrice(Optional<Double> minPrice) {
        this.minPrice = minPrice;
    }

    public Optional<Double> getMaxPrice() {
        return maxPrice;
    }

    public void setMaxPrice(Optional<Double> maxPrice) {
        this.maxPrice = maxPrice;
    }

    public Optional<List<String>> getCpu() {
        return cpu;
    }

    public void setCpu(Optional<List<String>> cpu) {
        this.cpu = cpu;
    }

    public Optional<List<String>> getRam() {
        return ram;
    }

    public void setRam(Optional<List<String>> ram) {
        this.ram = ram;
    }

    public Optional<String> getPage() {
        return page;
    }

    public void setPage(Optional<String> page) {
        this.page = page;
    }

    public Optional<String> getName() {
        return name;
    }

    public void setName(Optional<String> name) {
        this.name = name;
    }

    public Optional<List<String>> getFactory() {
        return factory;
    }

    public void setFactory(Optional<List<String>> factory) {
        this.factory = factory;
    }

    public Optional<List<String>> getTarget() {
        return target;
    }

    public void setTarget(Optional<List<String>> target) {
        this.target = target;
    }

    public Optional<List<String>> getPrice() {
        return price;
    }

    public void setPrice(Optional<List<String>> price) {
        this.price = price;
    }

    public Optional<String> getSort() {
        return sort;
    }

    public void setSort(Optional<String> sort) {
        this.sort = sort;
    }

}
