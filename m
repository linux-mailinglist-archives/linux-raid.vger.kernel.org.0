Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33114516E4B
	for <lists+linux-raid@lfdr.de>; Mon,  2 May 2022 12:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383244AbiEBKqm (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 2 May 2022 06:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384700AbiEBKqc (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 2 May 2022 06:46:32 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CDAF20BC5
        for <linux-raid@vger.kernel.org>; Mon,  2 May 2022 03:42:46 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id y3so26931663ejo.12
        for <linux-raid@vger.kernel.org>; Mon, 02 May 2022 03:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=QRCVia859CvI1FcacIK/vRlTfJd+SbxpysHOvI3snNU=;
        b=lyBBuq20VGLujMZIln/RPA0TbRIXRwGgT00v/39xRd5E1z2+QFjMNpcdxoqXcKNhB/
         gvAGrkN3w1RT5/9YLmjKH9ctGCNK3G0+0+OF8mohV2h5eKjILIf5jRZg0i0xBmyyWfXt
         TmTTKgN0cikOP3q1Ovi0U7UXYiLnSznR7tiTRjCnBB04MHFXQ3cOPwYAwrAJDTM1mNQc
         zer6tjPhTJWW2DEHGGZGoR8AFSERKCZC6038RZEzvzS4DrJXYMjyajSKhzvynpRWJ3ay
         2aOvHVcbdr/WtT68kQmZJOMs2FqCT5v2ikaHII3jcgCfuSex44S/Z7igh1NKxGpr39uh
         UmbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=QRCVia859CvI1FcacIK/vRlTfJd+SbxpysHOvI3snNU=;
        b=0pnI/BhVx8XRNH+xv2YHegFCdovgcXia4hzhwllCaCVwd5OvJVchlcsnfRSPfXl0Pd
         MDxey4cabDy5S5wzxE0gUwGYO9NHbvARc4eIOE65WrrIf1p3OW8Gv2+SqeAUgplRAuog
         bQQrHT9iAw0J9Z1Dz1um+9wzpZk93NYhFqjvqvxMvh6RDTEkrgZOR/1yXTlZ67cLSAVG
         W4XGa7MsgAXQ4thlc9b+pHzPkTNgKvJGx61WC8T7aNwbjXzlrWtX+/qmsrBXGeXdgFht
         HWIb9beJWRckXMWsfPDvhH9oS0wb15BILjWWklI9PBlN90EUl6YHbfkIqWKmsYf+Et9a
         gVTw==
X-Gm-Message-State: AOAM533V0X8gdLEmKaD36iaWO15jY6D+5gpVOeI8Tactq1rdDWbMqUoD
        vDvmglGfWnUTmeAQw1MCDWAapSuLdrSLTSun0j8=
X-Google-Smtp-Source: ABdhPJxsfHDNYOBlES93VKXQTHq2VCOwAT4KbrrPu0+k450y99k+SVq8+XY87vWTYflFKJkest82OIFFgJZLwMvDnW8=
X-Received: by 2002:a17:906:38d9:b0:6e8:3f85:4da3 with SMTP id
 r25-20020a17090638d900b006e83f854da3mr10823963ejd.196.1651488164492; Mon, 02
 May 2022 03:42:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a54:3147:0:0:0:0:0 with HTTP; Mon, 2 May 2022 03:42:43 -0700 (PDT)
From:   Frank David <frankdavidloanfirm3@gmail.com>
Date:   Mon, 2 May 2022 03:42:43 -0700
Message-ID: <CACPaKzkjYV6WXW=s8+MeA9WOgjDQ4Da=TxCqfq+0SBFCE-o35g@mail.gmail.com>
Subject: =?UTF-8?B?0J7RhNC10YDRgtCwINC30LAg0LfQsNC10Lw=?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

0JfQtNGA0LDQstC10LnRgtC1Lg0KDQrQotC+0LLQsCDQuNC80LAg0LfQsCDRhtC10Lsg0LTQsCDQ
uNC90YTQvtGA0LzQuNGA0LAg0YjQuNGA0L7QutCw0YLQsCDQvtCx0YnQtdGB0YLQstC10L3QvtGB
0YIsINGH0LUg0LMt0L0g0KTRgNCw0L3Qug0K0JTQtdC50LLQuNC0LCDRh9Cw0YHRgtC10L0g0LfQ
sNC10Lwg0L7RgiDQt9Cw0LXQvNC+0LTQsNGC0LXQuywg0L7RgtCy0L7RgNC4INC40LrQvtC90L7Q
vNC40YfQtdGB0LrQsCDQstGK0LfQvNC+0LbQvdC+0YHRgiDQt9CwDQrRgtC10LfQuCwg0LrQvtC4
0YLQviDRgdC1INC90YPQttC00LDRj9GCINC+0YIg0YTQuNC90LDQvdGB0L7QstCwINC/0L7QvNC+
0YkuINCd0LjQtSDQvtGC0L/Rg9GB0LrQsNC80LUg0LfQsNC10LzQuCDQvdCwDQrRhNC40LfQuNGH
0LXRgdC60Lgg0LvQuNGG0LAsINGE0LjRgNC80Lgg0Lgg0YTQuNGA0LzQuCDQv9GA0Lgg0Y/RgdC9
0Lgg0Lgg0YDQsNC30LHQuNGA0LDQtdC80Lgg0YPRgdC70L7QstC40Y8g0YEg0LvQuNGF0LLQsCDQ
vtGCDQrRgdCw0LzQviAzJS4g0YHQstGK0YDQttC10YLQtSDRgdC1INGBINC90LDRgSDQtNC90LXR
gSDRh9GA0LXQtyDQuNC80LXQudC7OiAoDQpmcmFua2RhdmlkbG9hbmZpcm0zQGdtYWlsLmNvbSks
INC30LAg0LTQsCDQvNC+0LbQtdC8INC00LAg0LLQuCDQv9GA0LXQtNC+0YHRgtCw0LLQuNC8INC9
0LDRiNC40YLQtQ0K0YPRgdC70L7QstC40Y8g0LfQsCDQt9Cw0LXQvC4NCg0K0JjQndCk0J7QoNCc
0JDQptCY0K8g0LrRitC8INC60YDQtdC00LjRgtC+0L/QvtC70YPRh9Cw0YLQtdC70Y8NCg0KMSkg
0JjQvNC1OiAuLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4g
Li4uLg0KDQoyKSDQlNGK0YDQttCw0LLQsDogLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLiAuDQoNCjMpINCQ0LTRgNC10YE6IC4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4gLg0KDQo0KSDQn9C+0Ls6IC4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLiAuLi4uLg0KDQo1KSDQodC10LzQtdC5
0L3QviDQv9C+0LvQvtC20LXQvdC40LU6IC4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4NCg0KNikg0J/RgNC+0YTQtdGB0LjRjzogLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLg0KDQo3KSDQotC10LvQtdGE0L7QvTogLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uDQoNCjgpINCa0LDQvdC00LjQ
tNCw0YLRgdGC0LLQsNC70Lgg0LvQuCDRgdGC0LUg0L/RgNC10LTQuCAuLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4NCg0KOSkg0JzQtdGB0LXRh9C10L0g0LTQvtGF0L7QtDogLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLg0KDQoxMCkg0J3QtdC+0LHRhdC+0LTQ
uNC80LAg0YHRg9C80LAg0L3QsCDQt9Cw0LXQvNCwOiAuLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLg0KDQoxMSkg0J/RgNC+0LTRitC70LbQuNGC0LXQu9C90L7RgdGCINC90LAg0LfQ
sNC10LzQsDogLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLg0K
DQoxMikg0KbQtdC7INC90LAg0LfQsNC10LzQsDogLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uDQoNCjEzKSDQoNC10LvQuNCz0LjRjzogLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uIC4NCg0KDQrQl9CwINCy0YDRitC3
0LrQsDogKCBmcmFua2RhdmlkbG9hbmZpcm0zQGdtYWlsLmNvbSApIHdoYXRzYXBwOyArMjM0NzAz
MjkwOTcyOA0KDQoNCtCR0LvQsNCz0L7QtNCw0YDRjywNCtCTLdC9INCk0YDQsNC90Log0JTQtdC5
0LLQuNC0DQo=
