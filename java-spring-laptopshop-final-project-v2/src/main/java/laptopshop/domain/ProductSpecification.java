package laptopshop.domain;

import jakarta.persistence.*;
import java.io.Serializable;

@Entity
@Table(name = "product_specifications")
public class ProductSpecification implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    // Processor
    private String cpuCompany;
    private String cpuTechnology;
    private String cpuType;
    private String cpuSpeed;
    private String cpuMaxSpeed;

    // Graphics
    private String gpuCompany;
    private String gpuModel;
    private String gpuFullName;

    // RAM
    private String ramCapacity;
    private String ramType;
    private String ramSlots;
    private String ramRemainingSlots;
    private String ramMaxSupport;

    // Storage
    private String storageType;
    private String storageTotalSlots;
    private String storageRemainingSlots;
    private String storageMaxUpgrade;
    private String storageSsdType;
    private String storageCapacity;

    // Display
    private String screenTechnology;
    private String screenResolution;
    private String screenRefreshRate;
    private String screenPanel;
    private String screenBrightness;
    private String screenColorCoverage;
    private String screenRatio;

    // Connectivity
    private String ports;
    private String wifi;
    private String bluetooth;
    private String webcam;

    // OS & Security
    private String osName;
    private String osVersion;
    private String security;

    // Keyboard & Touchpad
    private String keyboardType;
    private String numpad;
    private String keyboardLight;
    private String touchpad;

    // Battery & Power
    private String batteryCapacity;
    private String powerSupply;

    // Accessories
    private String accessories;

    // Design & Weight
    private String dimensions;
    private String weight;
    private String material;

    // Product Info
    private String partNumber;
    private String origin;
    private String releaseYear;
    private String warranty;

    // Getters and Setters

    public long getId() { return id; }
    public void setId(long id) { this.id = id; }

    public String getCpuCompany() { return cpuCompany; }
    public void setCpuCompany(String cpuCompany) { this.cpuCompany = cpuCompany; }

    public String getCpuTechnology() { return cpuTechnology; }
    public void setCpuTechnology(String cpuTechnology) { this.cpuTechnology = cpuTechnology; }

    public String getCpuType() { return cpuType; }
    public void setCpuType(String cpuType) { this.cpuType = cpuType; }

    public String getCpuSpeed() { return cpuSpeed; }
    public void setCpuSpeed(String cpuSpeed) { this.cpuSpeed = cpuSpeed; }

    public String getCpuMaxSpeed() { return cpuMaxSpeed; }
    public void setCpuMaxSpeed(String cpuMaxSpeed) { this.cpuMaxSpeed = cpuMaxSpeed; }

    public String getGpuCompany() { return gpuCompany; }
    public void setGpuCompany(String gpuCompany) { this.gpuCompany = gpuCompany; }

    public String getGpuModel() { return gpuModel; }
    public void setGpuModel(String gpuModel) { this.gpuModel = gpuModel; }

    public String getGpuFullName() { return gpuFullName; }
    public void setGpuFullName(String gpuFullName) { this.gpuFullName = gpuFullName; }

    public String getRamCapacity() { return ramCapacity; }
    public void setRamCapacity(String ramCapacity) { this.ramCapacity = ramCapacity; }

    public String getRamType() { return ramType; }
    public void setRamType(String ramType) { this.ramType = ramType; }

    public String getRamSlots() { return ramSlots; }
    public void setRamSlots(String ramSlots) { this.ramSlots = ramSlots; }

    public String getRamRemainingSlots() { return ramRemainingSlots; }
    public void setRamRemainingSlots(String ramRemainingSlots) { this.ramRemainingSlots = ramRemainingSlots; }

    public String getRamMaxSupport() { return ramMaxSupport; }
    public void setRamMaxSupport(String ramMaxSupport) { this.ramMaxSupport = ramMaxSupport; }

    public String getStorageType() { return storageType; }
    public void setStorageType(String storageType) { this.storageType = storageType; }

    public String getStorageTotalSlots() { return storageTotalSlots; }
    public void setStorageTotalSlots(String storageTotalSlots) { this.storageTotalSlots = storageTotalSlots; }

    public String getStorageRemainingSlots() { return storageRemainingSlots; }
    public void setStorageRemainingSlots(String storageRemainingSlots) { this.storageRemainingSlots = storageRemainingSlots; }

    public String getStorageMaxUpgrade() { return storageMaxUpgrade; }
    public void setStorageMaxUpgrade(String storageMaxUpgrade) { this.storageMaxUpgrade = storageMaxUpgrade; }

    public String getStorageSsdType() { return storageSsdType; }
    public void setStorageSsdType(String storageSsdType) { this.storageSsdType = storageSsdType; }

    public String getStorageCapacity() { return storageCapacity; }
    public void setStorageCapacity(String storageCapacity) { this.storageCapacity = storageCapacity; }

    public String getScreenTechnology() { return screenTechnology; }
    public void setScreenTechnology(String screenTechnology) { this.screenTechnology = screenTechnology; }

    public String getScreenResolution() { return screenResolution; }
    public void setScreenResolution(String screenResolution) { this.screenResolution = screenResolution; }

    public String getScreenRefreshRate() { return screenRefreshRate; }
    public void setScreenRefreshRate(String screenRefreshRate) { this.screenRefreshRate = screenRefreshRate; }

    public String getScreenPanel() { return screenPanel; }
    public void setScreenPanel(String screenPanel) { this.screenPanel = screenPanel; }

    public String getScreenBrightness() { return screenBrightness; }
    public void setScreenBrightness(String screenBrightness) { this.screenBrightness = screenBrightness; }

    public String getScreenColorCoverage() { return screenColorCoverage; }
    public void setScreenColorCoverage(String screenColorCoverage) { this.screenColorCoverage = screenColorCoverage; }

    public String getScreenRatio() { return screenRatio; }
    public void setScreenRatio(String screenRatio) { this.screenRatio = screenRatio; }

    public String getPorts() { return ports; }
    public void setPorts(String ports) { this.ports = ports; }

    public String getWifi() { return wifi; }
    public void setWifi(String wifi) { this.wifi = wifi; }

    public String getBluetooth() { return bluetooth; }
    public void setBluetooth(String bluetooth) { this.bluetooth = bluetooth; }

    public String getWebcam() { return webcam; }
    public void setWebcam(String webcam) { this.webcam = webcam; }

    public String getOsName() { return osName; }
    public void setOsName(String osName) { this.osName = osName; }

    public String getOsVersion() { return osVersion; }
    public void setOsVersion(String osVersion) { this.osVersion = osVersion; }

    public String getSecurity() { return security; }
    public void setSecurity(String security) { this.security = security; }

    public String getKeyboardType() { return keyboardType; }
    public void setKeyboardType(String keyboardType) { this.keyboardType = keyboardType; }

    public String getNumpad() { return numpad; }
    public void setNumpad(String numpad) { this.numpad = numpad; }

    public String getKeyboardLight() { return keyboardLight; }
    public void setKeyboardLight(String keyboardLight) { this.keyboardLight = keyboardLight; }

    public String getTouchpad() { return touchpad; }
    public void setTouchpad(String touchpad) { this.touchpad = touchpad; }

    public String getBatteryCapacity() { return batteryCapacity; }
    public void setBatteryCapacity(String batteryCapacity) { this.batteryCapacity = batteryCapacity; }

    public String getPowerSupply() { return powerSupply; }
    public void setPowerSupply(String powerSupply) { this.powerSupply = powerSupply; }

    public String getAccessories() { return accessories; }
    public void setAccessories(String accessories) { this.accessories = accessories; }

    public String getDimensions() { return dimensions; }
    public void setDimensions(String dimensions) { this.dimensions = dimensions; }

    public String getWeight() { return weight; }
    public void setWeight(String weight) { this.weight = weight; }

    public String getMaterial() { return material; }
    public void setMaterial(String material) { this.material = material; }

    public String getPartNumber() { return partNumber; }
    public void setPartNumber(String partNumber) { this.partNumber = partNumber; }

    public String getOrigin() { return origin; }
    public void setOrigin(String origin) { this.origin = origin; }

    public String getReleaseYear() { return releaseYear; }
    public void setReleaseYear(String releaseYear) { this.releaseYear = releaseYear; }

    public String getWarranty() { return warranty; }
    public void setWarranty(String warranty) { this.warranty = warranty; }
}
