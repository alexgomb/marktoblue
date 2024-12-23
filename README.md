![MarkToBlue Banner](https://github.com/alexgomb/marktoblue/blob/main/logo.png)
# MarkToBlue: Illuminating the Difference

**Author**: Alejandro Gombau García  
**Date**: `23/12/24`

MarkToBlue is a computational approach designed to help quantify and compare immunostaining signals from tissue or cell culture images. By normalizing a marker channel (often in green) to a nuclear stain or baseline channel (often in blue), MarkToBlue strives to reduce variability arising from differences in cell confluence, fluorescence fading, antibody concentration, and other factors.
## Background

Immunocytochemistry (ICC) and immunohistochemistry (IHC) are widely used techniques for localizing specific antigens in tissue samples or cultured cells. However, these methods often present challenges for absolute quantification due to variability in:

- Cell density and confluence  
- Photobleaching and fluorescence fading  
- Subtle differences in antibody concentration or staining conditions  

MarkToBlue addresses these issues by using a ratio-based normalization strategy, comparing signal intensity in the green channel (target marker) against the blue channel (e.g., DAPI or Hoechst for nuclei).

---

## How It Works

MarkToBlue applies the following steps to each image:

1. **Read the image and separate color channels** (blue and green).  
2. **Mask generation**: Identify pixels above a user-defined threshold in both channels.  
3. **Area calculation**: Count the number of non-zero (or above-threshold) pixels in each channel.  
4. **Brightness calculation**: Compute the mean pixel intensity (within each mask).  
5. **Ratio computation**:

MarkToBlue Ratio = (Area_green × Brightness_green) / (Area_blue × Brightness_blue)


This ratio provides a comparative measure of marker signal relative to a baseline or nuclear stain.


# References

    Camp RL, Chung GG, Rimm DL. Automated subcellular localization and quantification of protein expression in tissue microarrays. Nat Med. 2002;8(11):1323-1327. doi: 10.1038/nm791
    Carpenter, A. E., Jones, T. R., Lamprecht, M. R. et al. CellProfiler: image analysis software for identifying and quantifying cell phenotypes. Genome Biol 7, R100 (2006). doi: 10.1186/gb-2006-7-10-r100

# Future Prospects

    Statistical Validation: Incorporate bootstrapping or additional replicates to validate ratio accuracy.
    Extended Channel Support: Add red or far-red channels for multi-marker analysis.
    Containerization: Provide official Docker/Container solutions for reproducible deployment.
    Enhanced UI: Expand the Shiny app with advanced plotting and batch processing features.
