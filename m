Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9D905AE88F
	for <lists+linux-raid@lfdr.de>; Tue,  6 Sep 2022 14:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232666AbiIFMjT (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 6 Sep 2022 08:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231700AbiIFMjS (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 6 Sep 2022 08:39:18 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7EA626119
        for <linux-raid@vger.kernel.org>; Tue,  6 Sep 2022 05:39:17 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id q63so10500402pga.9
        for <linux-raid@vger.kernel.org>; Tue, 06 Sep 2022 05:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date;
        bh=lb7mKHsaIcUxW+3Jy2BJQ41sCMA+sLqu9myEjLcTq6E=;
        b=qCNGl5vw1Rp1JAJf2CoWp5cZ+hqwn8317SMrAQ82JBgMYPnfaI3hlomJwVoC3Mcy3d
         HyRoYMtFNHxVbGYDLrXQxZUAKi4a65XunYle39ecqmUYjQlOlhQJCzeNbmwlE9H2UC/Q
         +YiMpbqkAV3EV4r3quyENt+TyqV+UYn2N3AIXpeE9E6vQixLO/bR5BEMdcFrsXUJ9XOW
         10rK2LlcJ5rJygcPBxZPxid89nqXkFMi5g6Dp4+8WRyryvdvsQusYxUBFAVqOjQe0s+H
         1LczXhqMTmi47ea3rASusmzyqtjj3D3jJirqeXX9YInMOXxK1r9p6Hk5OBh5Sv7S/kD7
         rw+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=lb7mKHsaIcUxW+3Jy2BJQ41sCMA+sLqu9myEjLcTq6E=;
        b=1x5ky4yPFW0DuQSg3w5zWN7dX5fEicMgxDORJlECKidGeCJtOglnQQQFGaariNNKnc
         Q1FoozDdLUu+/5qR/oPevVpXOmvdaYnwDdToABWSzR7bIyQeWN0Or9DhwJYXaD8Cg+IY
         gOXPl6sC2/iB5ee0Rn88b8bw8+f4Fw0OnBSwNPnJFh/5J1jBqErLqT5lsA5VK24Cj28R
         43NSV5ZuWQtt3KRiyjQdnVU8EbgeJY73kYgHKEZNflv4x3CmIUnUoT3PSSfDvw3p5XgT
         xjfylRXfJHo6Y5yOlryEA5+6cN/jJHb3dljkCwJ8wOSwg4YCqof2jlYZ7r6RGDdibPit
         +6cw==
X-Gm-Message-State: ACgBeo03BaHkVJK+E2HF1wOz1IdOTCsfWnYCHJlW2yTERzz6zBeCeIJ5
        JeTpj/I4mOkwqoEkcW7rsiIziOjTywfjwTDEzLrECbhP
X-Google-Smtp-Source: AA6agR7WSk/buCHxY7CB6Ii17+6essnU4J2czmv98TJ2Bwidpgdn/m4/6LJEEN29n8nKHG7Il1Yjof9E8o7eF7srI74=
X-Received: by 2002:a63:e317:0:b0:432:38c0:bde3 with SMTP id
 f23-20020a63e317000000b0043238c0bde3mr15822464pgh.567.1662467957492; Tue, 06
 Sep 2022 05:39:17 -0700 (PDT)
MIME-Version: 1.0
Sender: ndubuisio992@gmail.com
Received: by 2002:a05:7300:c09:b0:6f:e3f6:8ca4 with HTTP; Tue, 6 Sep 2022
 05:39:17 -0700 (PDT)
From:   Jessica Daniel <jessicadaniel7833@gmail.com>
Date:   Tue, 6 Sep 2022 12:39:17 +0000
X-Google-Sender-Auth: hx-dRgF0c1IU3pyOJ6ozfcMMQg4
Message-ID: <CAO7YTNmsAO3VB9bBWrmRKsrFHNErNMiz641y-nYu86bDMbg8cQ@mail.gmail.com>
Subject: Hi
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

-- 
Hello Dear,
Did you receive my mail
thanks??
